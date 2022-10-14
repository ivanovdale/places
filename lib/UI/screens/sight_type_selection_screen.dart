import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_divider.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/custom_icon_button.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/utils/string_extension.dart';

/// Экран выбора категории достопримечательности.
class SightTypeSelectionScreen extends StatelessWidget {
  const SightTypeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: AppStrings.sightType.capitalize(),
        titleTextStyle: Theme.of(context).textTheme.subtitle1,
        centerTitle: true,
        toolbarHeight: 56,
        leading: const _BackButton(),
      ),
      body: const _SightTypeSelectionBody(),
    );
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedSightTypeSelectionBodyState extends InheritedWidget {
  final _SightTypeSelectionBodyState data;

  const _InheritedSightTypeSelectionBodyState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedSightTypeSelectionBodyState old) {
    return true;
  }

  static _SightTypeSelectionBodyState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
                _InheritedSightTypeSelectionBodyState>()
            as _InheritedSightTypeSelectionBodyState)
        .data;
  }
}

/// Выбор категории достопримечательности.
class _SightTypeSelectionBody extends StatefulWidget {
  const _SightTypeSelectionBody({Key? key}) : super(key: key);

  @override
  State<_SightTypeSelectionBody> createState() =>
      _SightTypeSelectionBodyState();
}

/// Состояние выбора категории достопримечательности. Хранит текущую выбранную категорию.
class _SightTypeSelectionBodyState
    extends State<_SightTypeSelectionBody> {
  SightTypes? currentSightType;

  @override
  Widget build(BuildContext context) {
    return _InheritedSightTypeSelectionBodyState(
      data: this,
      child: const _SightTypesList(),
    );
  }

  /// Устанавливает новое значение выбранного типа места.
  void setCurrentSightType(SightTypes item) {
    setState(() {
      currentSightType = item;
    });
  }
}

/// Список категорий достопримечательности.
class _SightTypesList extends StatelessWidget {
  const _SightTypesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Column(
            children: SightTypes.values
                .map((sightType) => _SightTypeItem(item: sightType))
                .toList(),
          ),
          const Spacer(),
          const _SaveButton(),
        ],
      ),
    );
  }
}

/// Элемент списка категории достопримечательности.
///
/// Отображает имя достопримечательности и галочку выбора.
/// Устанавливает текущий выбранный тип достопримечательности.
class _SightTypeItem extends StatelessWidget {
  final SightTypes item;

  const _SightTypeItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage =
        _InheritedSightTypeSelectionBodyState.of(context);
    final currentSightType = dataStorage.currentSightType;
    final theme = Theme.of(context);
    final itemName = item.name;

    return InkWell(
      onTap: () => dataStorage.setCurrentSightType(item),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  itemName.capitalize(),
                  style: theme.textTheme.bodyText1,
                ),
              ),
              const Spacer(),
              if (itemName == currentSightType?.name)
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Icon(
                    Icons.done_outlined,
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
          CustomDivider(
            thickness: 0.8,
            color: theme.colorScheme.secondary.withOpacity(0.15),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Кнопка сохранения категории достопримечательности.
class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage =
        _InheritedSightTypeSelectionBodyState.of(context);
    final currentSightType = dataStorage.currentSightType;

    // Логика изменения цвета кнопки в зависимости от выбранной категории.
    final theme = Theme.of(context);
    var saveButtonBackgroundColor = theme.colorScheme.primary;
    var saveButtonTextColor = theme.colorScheme.onBackground;
    if (currentSightType == null) {
      saveButtonBackgroundColor = theme.colorScheme.secondaryContainer;
      saveButtonTextColor = theme.colorScheme.secondary.withOpacity(0.56);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 24.0,
      ),
      child: CustomElevatedButton(
        AppStrings.save,
        backgroundColor: saveButtonBackgroundColor,
        height: 48,
        textStyle: theme.textTheme.bodyText2?.copyWith(
          color: saveButtonTextColor,
          fontWeight: FontWeight.w700,
        ),
        onPressed: () {
          if (currentSightType != null) {
            Navigator.pop(context, currentSightType);
          }
        },
      ),
    );
  }
}

/// Кнопка возврата на экран добавления достопримечательности.
class _BackButton extends StatelessWidget {
  const _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      padding: const EdgeInsets.only(left: 16.0),
      icon: Icons.arrow_back_ios_new_rounded,
      size: 16.0,
      color: Theme.of(context).primaryColorDark,
    );
  }
}
