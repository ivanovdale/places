import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_divider.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/UI/screens/components/custom_icon_button.dart';
import 'package:places/data/model/place.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/utils/string_extension.dart';

/// Экран выбора категории места.
class PlaceTypeSelectionScreen extends StatelessWidget {
  const PlaceTypeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: AppStrings.placeType.capitalize(),
        titleTextStyle: Theme.of(context).textTheme.subtitle1,
        centerTitle: true,
        toolbarHeight: 56,
        leading: const _BackButton(),
      ),
      body: const _PlaceTypeSelectionBody(),
    );
  }
}

/// Прокидывает данные [data] вниз по дереву.
/// Всегда оповещает дочерние виджеты о перерисовке.
class _InheritedPlaceTypeSelectionBodyState extends InheritedWidget {
  final _PlaceTypeSelectionBodyState data;

  const _InheritedPlaceTypeSelectionBodyState({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedPlaceTypeSelectionBodyState old) {
    return true;
  }

  static _PlaceTypeSelectionBodyState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<
                _InheritedPlaceTypeSelectionBodyState>()
            as _InheritedPlaceTypeSelectionBodyState)
        .data;
  }
}

/// Выбор категории места.
class _PlaceTypeSelectionBody extends StatefulWidget {
  const _PlaceTypeSelectionBody({Key? key}) : super(key: key);

  @override
  State<_PlaceTypeSelectionBody> createState() =>
      _PlaceTypeSelectionBodyState();
}

/// Состояние выбора категории места. Хранит текущую выбранную категорию.
class _PlaceTypeSelectionBodyState
    extends State<_PlaceTypeSelectionBody> {
  PlaceTypes? currentPlaceType;

  @override
  Widget build(BuildContext context) {
    return _InheritedPlaceTypeSelectionBodyState(
      data: this,
      child: const _PlaceTypesList(),
    );
  }

  /// Устанавливает новое значение выбранного типа места.
  void setCurrentPlaceType(PlaceTypes item) {
    setState(() {
      currentPlaceType = item;
    });
  }
}

/// Список категорий места.
class _PlaceTypesList extends StatelessWidget {
  const _PlaceTypesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Column(
            children: PlaceTypes.values
                .map((placeType) => _PlaceTypeItem(item: placeType))
                .toList(),
          ),
          const Spacer(),
          const _SaveButton(),
        ],
      ),
    );
  }
}

/// Элемент списка категории места.
///
/// Отображает имя места и галочку выбора.
/// Устанавливает текущий выбранный тип места.
class _PlaceTypeItem extends StatelessWidget {
  final PlaceTypes item;

  const _PlaceTypeItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage =
        _InheritedPlaceTypeSelectionBodyState.of(context);
    final currentPlaceType = dataStorage.currentPlaceType;
    final theme = Theme.of(context);
    final itemName = item.name;

    return InkWell(
      onTap: () => dataStorage.setCurrentPlaceType(item),
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
              if (itemName == currentPlaceType?.name)
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

/// Кнопка сохранения категории места.
class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage =
        _InheritedPlaceTypeSelectionBodyState.of(context);
    final currentPlaceType = dataStorage.currentPlaceType;

    // Логика изменения цвета кнопки в зависимости от выбранной категории.
    final theme = Theme.of(context);
    var saveButtonBackgroundColor = theme.colorScheme.primary;
    var saveButtonTextColor = theme.colorScheme.onBackground;
    if (currentPlaceType == null) {
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
          if (currentPlaceType != null) {
            Navigator.pop(context, currentPlaceType);
          }
        },
      ),
    );
  }
}

/// Кнопка возврата на экран добавления места.
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
