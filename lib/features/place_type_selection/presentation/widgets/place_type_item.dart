import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/UI/screens/components/custom_divider.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/place_type_selection/presentation/cubit/place_type_selection_cubit.dart';
import 'package:places/utils/string_extension.dart';

/// Элемент списка категории места.
///
/// Отображает имя места и галочку выбора.
/// Устанавливает текущий выбранный тип места.
class PlaceTypeItem extends StatelessWidget {
  final PlaceTypes item;
  final bool useDivider;

  const PlaceTypeItem({
    Key? key,
    required this.item,
    required this.useDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PlaceTypeSelectionCubit>();
    final currentPlaceType = cubit.state.placeType;
    final theme = Theme.of(context);
    final itemName = item.text;
    final isItemChosen = item == currentPlaceType;

    return InkWell(
      onTap: () => cubit.setCurrentPlaceType(item),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                Text(
                  itemName.capitalize(),
                  style: theme.textTheme.bodyLarge,
                ),
                const Spacer(),
                if (isItemChosen)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.done_outlined,
                      color: theme.colorScheme.primary,
                      size: 18,
                    ),
                  ),
              ],
            ),
          ),
          if (useDivider)
            CustomDivider(
              height: 0,
              thickness: 0.8,
              color: theme.colorScheme.secondary.withOpacity(0.15),
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
            ),
        ],
      ),
    );
  }
}
