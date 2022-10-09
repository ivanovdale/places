import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_divider.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/UI/screens/sight_category_selection_screen.dart';
import 'package:places/domain/coordinate_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/utils/replace_comma_formatter.dart';
import 'package:places/utils/string_extension.dart';

/// Экран для добавления новой достопримечательности.
///
/// Позволяет выбрать категорию места, ввести его название, описание и географические координаты.
/// Также координаты можно установить, указав точку на карте.
class AddSightScreen extends StatelessWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.newPlace.capitalize(),
          titleTextStyle: Theme.of(context).textTheme.subtitle1,
          centerTitle: true,
          toolbarHeight: 56,
          leading: const _CancelButton(),
          leadingWidth: 73,
        ),
        body: const _AddSightBody(),
      ),
    );
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedAddSightBodyState extends InheritedWidget {
  final _AddSightBodyState data;

  const _InheritedAddSightBodyState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedAddSightBodyState old) {
    return true;
  }

  static _AddSightBodyState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
            _InheritedAddSightBodyState>() as _InheritedAddSightBodyState)
        .data;
  }
}

/// Отображает свойства добавленяемого места: категория, название, описание, координаты.
/// Позволяет ввести географические координаты места, указав точку на карте.
/// Имеет кнопку "Создать" для добавления нового места.
class _AddSightBody extends StatefulWidget {
  const _AddSightBody({Key? key}) : super(key: key);

  @override
  State<_AddSightBody> createState() => _AddSightBodyState();
}

/// Состояние виджета для добавления нового места.
///
/// Содержит в себе всю верстку, контроллеры и фокусноды для полей ввода.
/// Также содержит ключ формы для валидации полей.
/// Хранит выбранный тип места.
class _AddSightBodyState extends State<_AddSightBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _latitudeFocusNode = FocusNode();
  final FocusNode _longitudeFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  /// Для валидации координат достопримечательности.
  final _formKey = GlobalKey<FormState>();
  SightTypes? selectedSightType;

  @override
  Widget build(BuildContext context) {
    const defaultLabelPadding = EdgeInsets.only(
      left: 16.0,
      bottom: 12.0,
    );

    return SingleChildScrollView(
      child: _InheritedAddSightBodyState(
        data: this,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _CategoryLabel(),
              _CategorySelectionField(),
              _PaddedDivider(),
              _NameLabel(padding: defaultLabelPadding),
              _NameTextField(),
              _MapTextFields(),
              _MarkOnMapButton(),
              _DescriptionLabel(padding: defaultLabelPadding),
              _DescriptionTextField(),
              _CreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Для обновления SuffixIcon в TextField.
    _nameFocusNode.addListener(() {
      setState(() {});
    });
    _latitudeFocusNode.addListener(() {
      setState(() {});
    });
    _longitudeFocusNode.addListener(() {
      setState(() {});
    });
    _descriptionFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _descriptionController.dispose();
    _nameFocusNode.dispose();
    _latitudeFocusNode.dispose();
    _longitudeFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }

  /// Устанавливает выбранный тип места.
  void setSelectedSightType(SightTypes selectedSightType) {
    setState(() {
      this.selectedSightType = selectedSightType;
    });
  }
}

/// Заголовок поля "Категория".
class _CategoryLabel extends StatelessWidget {
  const _CategoryLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _LabelFieldText(
      AppStrings.category,
      padding: EdgeInsets.only(
        left: 16.0,
        top: 24.0,
      ),
    );
  }
}

/// Заголовок поля "Наименование" места.
class _NameLabel extends StatelessWidget {
  final EdgeInsets? padding;

  const _NameLabel({
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _LabelFieldText(
      AppStrings.name,
      padding: padding,
    );
  }
}

/// Заголовок поля "Описание" места.
class _DescriptionLabel extends StatelessWidget {
  final EdgeInsets? padding;

  const _DescriptionLabel({
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _LabelFieldText(
      AppStrings.description,
      padding: padding,
    );
  }
}

/// Заголовок поля "Широта" координат места.
class _LatitudeLabel extends StatelessWidget {
  const _LatitudeLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 16.0, top: 24, bottom: 12);

    return const _LabelFieldText(
      AppStrings.latitude,
      padding: padding,
    );
  }
}

/// Заголовок поля "Долгота" координат места.
class _LongitudeLabel extends StatelessWidget {
  const _LongitudeLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 8.0, top: 24, bottom: 12);

    return const _LabelFieldText(
      AppStrings.longitude,
      padding: padding,
    );
  }
}

/// Произвольный заголовок для поля ввода.
///
/// Нужно задать [labelText] - имя заголовка и при необходимости [padding] - отступ для заголовка.
class _LabelFieldText extends StatelessWidget {
  final String labelText;
  final EdgeInsets? padding;

  const _LabelFieldText(
    this.labelText, {
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        labelText,
        style: theme.textTheme.caption?.copyWith(
          color: theme.colorScheme.secondary.withOpacity(0.56),
        ),
      ),
    );
  }
}

/// Поле ввода наименования места.
class _NameTextField extends StatelessWidget {
  const _NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = _InheritedAddSightBodyState.of(context);
    final nameController = dataStorage._nameController;
    final nameFocusNode = dataStorage._nameFocusNode;
    final latitudeFocusNode = dataStorage._latitudeFocusNode;

    return _CustomTextFormField(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 40,
      controller: nameController,
      focusNode: nameFocusNode,
      nextFocusNode: latitudeFocusNode,
      maxLength: 30,
      autofocus: true,
    );
  }
}

/// Поля ввода координат места.
class _MapTextFields extends StatelessWidget {
  const _MapTextFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _LatitudeLabel(),
              _LatitudeTextField(context: context),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _LongitudeLabel(),
              _LongitudeTextField(context: context),
            ],
          ),
        ),
      ],
    );
  }
}

/// Абстрактный класс для ввода координат места.
///
/// Валидирует поля ввода, позволяя вводить только десятичные числа.
/// Перемещает фокус на следующее поле при окончании редактирования.
/// Необходимо переопределить в потомках:
/// * [controller] - контроллер данного поля ввода;
/// * [focusNode] - фокусноду данного поля ввода;
/// * [nextFocusNode] - фокусноду, на которую необходимо переключиться после окончания ввода текста;
/// * [maxLength] - максимальную длину поля;
/// * [padding] - отступ для поля.
abstract class _BaseCoordinateTextField extends StatelessWidget {
  final BuildContext context;
  abstract final _AddSightBodyState dataStorage;
  abstract final TextEditingController controller;
  abstract final FocusNode focusNode;
  abstract final FocusNode? nextFocusNode;
  abstract final int maxLength;
  abstract final EdgeInsets? padding;

  const _BaseCoordinateTextField({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CustomTextFormField(
      controller: controller,
      focusNode: focusNode,
      nextFocusNode: nextFocusNode,
      height: 40,
      maxLength: maxLength,
      padding: padding,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        ReplaceCommaFormatter(),
      ],
      validator: coordinatePointValidator,
    );
  }

  /// Валидирует поля ввода, позволяя вводить только десятичные числа.
  String? coordinatePointValidator(String? value) {
    final digitsAndDots = RegExp(r'^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,4})?$');

    if (value == null || value.isEmpty || !digitsAndDots.hasMatch(value)) {
      return AppStrings.coordinatesValidationMessage;
    }

    return null;
  }
}

/// Поле ввода широты координат места.
///
/// Задаёт следующим полем для ввода - поле ввода долготы координат места.
/// Максимальная длина поля - 9 символов.
class _LatitudeTextField extends _BaseCoordinateTextField {
  @override
  _AddSightBodyState get dataStorage => _InheritedAddSightBodyState.of(context);

  @override
  TextEditingController get controller => dataStorage._latitudeController;

  @override
  FocusNode get focusNode => dataStorage._latitudeFocusNode;

  @override
  FocusNode? get nextFocusNode => dataStorage._longitudeFocusNode;

  @override
  int get maxLength => 9;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(
        left: 16.0,
        right: 8.0,
      );

  const _LatitudeTextField({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          context: context,
        );
}

/// Поле ввода долготы координат места.
///
/// Задаёт следующим полем для ввода - поле ввода описания места.
/// Максимальная длина поля - 10 символов.
class _LongitudeTextField extends _BaseCoordinateTextField {
  @override
  _AddSightBodyState get dataStorage => _InheritedAddSightBodyState.of(context);

  @override
  TextEditingController get controller => dataStorage._longitudeController;

  @override
  FocusNode get focusNode => dataStorage._longitudeFocusNode;

  @override
  FocusNode? get nextFocusNode => dataStorage._descriptionFocusNode;

  @override
  int get maxLength => 10;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(
        left: 8.0,
        right: 16.0,
      );

  const _LongitudeTextField({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          context: context,
        );
}

/// Поле ввода описания достопримечательности.
class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataStorage = _InheritedAddSightBodyState.of(context);
    final controller = dataStorage._descriptionController;
    final focusNode = dataStorage._descriptionFocusNode;

    return _CustomTextFormField(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 100,
      controller: controller,
      focusNode: focusNode,
      maxLength: 120,
      maxLines: 3,
      hintText: AppStrings.enterText,
      hintStyle: theme.textTheme.bodyText1?.copyWith(
        color: theme.colorScheme.secondary.withOpacity(0.56),
      ),
      unfocusWhenEditingComplete: true,
    );
  }
}

/// Произвольное поле ввода с настройками.
class _CustomTextFormField extends StatelessWidget {
  final EdgeInsets? padding;
  final double? height;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final int maxLength;
  final bool autofocus;
  final bool unfocusWhenEditingComplete;
  final String? hintText;
  final TextStyle? hintStyle;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const _CustomTextFormField({
    Key? key,
    this.padding,
    this.height,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.maxLength,
    this.autofocus = false,
    this.unfocusWhenEditingComplete = false,
    this.hintText,
    this.maxLines = 1,
    this.hintStyle,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchemePrimaryColor = theme.colorScheme.primary.withOpacity(0.4);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: height ?? 0,
        child: TextFormField(
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          autofocus: autofocus,
          textInputAction: (maxLines ?? 0) > 1 ? TextInputAction.done : null,
          maxLines: maxLines,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorSchemePrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: colorSchemePrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: focusNode.hasFocus
                ? IconButton(
                    icon: const Icon(Icons.cancel),
                    color: theme.primaryColorDark,
                    onPressed: controller.clear,
                  )
                : null,
          ),
          textAlignVertical: TextAlignVertical.top,
          style: theme.textTheme.bodyText1,
          onEditingComplete: changeFocus,
        ),
      ),
    );
  }

  /// Выполняет активацию нужного поля в зависимости от условия.
  ///
  /// Если определено поле следующего фокуса, то устанавливает его в качестве следующего поля ввода.
  /// Иначе если установлен признак отключения фокуса при завершении редактирования поля, то выполняет данное действие.
  void changeFocus() {
    if (nextFocusNode != null) {
      nextFocusNode?.requestFocus();
    } else {
      if (unfocusWhenEditingComplete) {
        focusNode.unfocus();
      }
    }
  }
}

/// Поле выбора категории достопримечательности.
class _CategorySelectionField extends StatelessWidget {
  const _CategorySelectionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectionFieldTextStyle = theme.textTheme.bodyText1?.copyWith(
      color: theme.colorScheme.secondary,
    );
    final dataStorage = _InheritedAddSightBodyState.of(context);
    final selectedSightType = dataStorage.selectedSightType;
    final selectedSightTypeName =
        selectedSightType?.name.capitalize() ?? AppStrings.unselected;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 14.0,
      ),
      child: InkWell(
        onTap: () => selectSightTypeFromListOnNewScreen(context),
        child: Row(
          children: [
            Text(
              selectedSightTypeName,
              style: selectionFieldTextStyle,
            ),
            const Spacer(),
            const _CategorySelectionButton(),
          ],
        ),
      ),
    );
  }

  /// Позволяет выбрать тип места из списка на новом экране.
  Future<void> selectSightTypeFromListOnNewScreen(BuildContext context) async {
    final dataStorage = _InheritedAddSightBodyState.of(context);

    final selectedSightType = await Navigator.push(
      context,
      MaterialPageRoute<SightTypes>(
        builder: (context) => const SightCategorySelectionScreen(),
      ),
    );

    if (selectedSightType != null) {
      dataStorage.setSelectedSightType(selectedSightType);
    }
  }
}

/// Кнопка отмены добавления нового места.
class _CancelButton extends StatelessWidget {
  const _CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.cancel,
      textStyle: theme.textTheme.button?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

/// Кнопка для выбора категории достопримечательности.
class _CategorySelectionButton extends StatelessWidget {
  const _CategorySelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).primaryColorDark,
        size: 15.0,
      ),
    );
  }
}

/// Кнопка указания достопримечательности на карте.
class _MarkOnMapButton extends StatelessWidget {
  const _MarkOnMapButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.markOnMap,
      textStyle: theme.textTheme.button?.copyWith(
        color: theme.colorScheme.primary,
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 12.0,
        bottom: 37.0,
      ),
    );
  }
}

/// Кнопка создания достопримечательности.
class _CreateButton extends StatelessWidget {
  /// Тип достопримечательности по умолчанию.
  SightTypes get _defaultSightType => SightTypes.particularPlace;

  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 24.0,
          bottom: 16.0,
        ),
        child: CustomElevatedButton(
          AppStrings.create,
          textStyle: theme.textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.secondary.withOpacity(0.56),
          ),
          backgroundColor: theme.colorScheme.secondaryContainer,
          height: 48,
          onPressed: () => createNewSight(context),
        ),
      ),
    );
  }

  /// Создаёт новую достопримечательность и возвращает её на предыдущий экран, если валидация полей прошла успешно.
  void createNewSight(BuildContext context) {
    final dataStorage = _InheritedAddSightBodyState.of(context);
    final isDataValid = dataStorage._formKey.currentState!.validate();

    if (isDataValid) {
      final newSight = Sight(
        name: dataStorage._nameController.text,
        coordinatePoint: CoordinatePoint(
          lat: double.parse(dataStorage._latitudeController.text),
          lon: double.parse(dataStorage._longitudeController.text),
        ),
        type: dataStorage.selectedSightType ?? _defaultSightType,
        details: dataStorage._descriptionController.text,
      );
      Navigator.of(context).pop(newSight);
    }
  }
}

/// Разделитель с заданной толщиной и отступами.
class _PaddedDivider extends StatelessWidget {
  const _PaddedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDivider(
      thickness: 0.8,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 24,
      ),
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
    );
  }
}
