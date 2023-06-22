import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/custom_pickers/custom_date_picker.dart';
import 'package:places/UI/screens/components/custom_pickers/custom_time_picker.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_place_cubit/favourite_place_cubit.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/favourite_places/presentation/widgets/cards/components/draggable_place_card_with_drag_target_option.dart';
import 'package:places/features/favourite_places/presentation/widgets/cards/to_visit_place_card.dart';
import 'package:places/features/favourite_places/presentation/widgets/cards/visited_place_card.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/base_visiting_place_list/base_visiting_place_list.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';

/// Время посещения места по умолчанию.
const int visitingHourByDefault = 12;

/// Состояние списка мест.
///
/// Содержит в себе скроллконтроллер для прокрутки списка в момент перетаскивания места.
class BaseVisitingPlaceListState extends State<BaseVisitingPlaceList> {
  final ScrollController _scrollController = ScrollController();
  bool isDragged = false;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listOfPlaces = widget.listOfPlaces;

    return listOfPlaces.isEmpty
        ? Builder(builder: widget.emptyVisitingList)
        : ListView.builder(
            controller: _scrollController,
            itemCount: listOfPlaces.length,
            itemBuilder: (context, index) {
              final place = listOfPlaces[index];

              return Stack(
                children: [
                  _BackgroundOnDismiss(
                    isDraggingActive: isDragged,
                  ),
                  Dismissible(
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) =>
                        context.read<FavouritePlacesBloc>().add(
                              RemoveFromFavouritesEvent(place),
                            ),
                    key: ObjectKey(place),
                    child: BlocProvider(
                      create: (context) => FavouritePlaceCubit(place),
                      child:
                          BlocBuilder<FavouritePlaceCubit, FavouritePlaceState>(
                        builder: (context, state) {
                          final placeCard = getPlaceCard(context, place);
                          final currentPlace = state.place;

                          return DraggablePlaceCardWithDragTargetOption(
                            index: index,
                            place: currentPlace,
                            placeCard: placeCard,
                            isDragged: isDragged,
                            onDragStarted: onDragStarted,
                            onDragEnd: (details) => onDragEnd(),
                            onAccept: (data) => widget.onPlaceInserted
                                ?.call(data, currentPlace),
                            scrollPlaceCardsWhenCardDragged:
                                scrollPlaceCardsWhenCardDragged,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
  }

  /// Возвращает карточку места в зависимости от типа поля placeCardType.
  BasePlaceCard getPlaceCard(BuildContext context, Place place) {
    return widget.placeCardType == ToVisitPlaceCard
        ? ToVisitPlaceCard(
            place,
            key: GlobalKey(),
            onDeletePressed: () => widget.onPlaceDeleted?.call(place),
            onCalendarPressed: () => showToVisitDateTimePicker(context, place),
          )
        : VisitedPlaceCard(
            place,
            key: GlobalKey(),
            // TODO(daniiliv): Вызов реальной функции.
            onSharePressed: () {},
            onDeletePressed: widget.onPlaceDeleted,
          );
  }

  /// Делает скролл вверх или вниз в зависимости от того, в какую область перетаскивается карточка места.
  void scrollPlaceCardsWhenCardDragged(PointerMoveEvent event) {
    const scrollArea = 300;

    final scrollPositionY = event.position.dy;
    if (scrollPositionY > MediaQuery.of(context).size.height - scrollArea) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );

      /// Скролл вверх при перетаскивании.
    } else if (scrollPositionY < scrollArea) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Устанавливает состояние - началось перетаскивание элемента.
  void onDragStarted() {
    setState(() {
      isDragged = true;
    });
  }

  /// Устанавливает состояние - завершилось перетаскивание элемента.
  void onDragEnd() {
    setState(() {
      isDragged = false;
    });
  }

  /// Отображает пикеры для выбора даты и времени посещения места.
  /// Записывает выбранные дату и время.
  Future<void> showToVisitDateTimePicker(
    BuildContext context,
    Place place,
  ) async {
    // Вытащим сохранённую дату посещения из модели места.
    // Необходима при редактировании уже сохранённой даты посещения.
    final savedToVisitDate = place.visitDate;

    // В зависимости от платформы показать нативный пикер/пикеры.
    if (Platform.isAndroid) {
      await showMaterialToVisitDateTimePickers(
        context,
        savedToVisitDate,
      );
    } else {
      if (Platform.isIOS) {
        await showCupertinoToVisitDateTimePicker(
          context,
          savedToVisitDate,
        );
      }
    }
  }

  /// Отображает пикер для выбора даты в стиле Material.
  Future<DateTime?> showMaterialToVisitDatePicker(
    DateTime? savedToVisitDate,
  ) async {
    final currentDateTime = DateTime.now();
    final initialDate = getPickerInitialDate(currentDateTime, savedToVisitDate);

    final pickedDate = showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 100)),
      initialDate: initialDate,
      builder: (context, child) {
        final theme = Theme.of(context);
        final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;

        return CustomDatePicker(
          child: child!,
          theme: Theme.of(context),
          colorSchemePrimary: theme.primaryColor,
          colorSchemeOnPrimary: scaffoldBackgroundColor,
          colorSchemeOnSurface: theme.primaryColorDark,
          dialogBackgroundColor: scaffoldBackgroundColor,
        );
      },
    );

    return pickedDate;
  }

  /// Отображает пикер для выбора времени в стиле Material.
  Future<TimeOfDay?> showMaterialToVisitTimePicker(
    DateTime? savedToVisitDate,
  ) async {
    // Если не задано сохранённое время посещения, то установить текущее время.
    final initialTime = savedToVisitDate != null
        ? TimeOfDay(
            hour: savedToVisitDate.hour,
            minute: savedToVisitDate.minute,
          )
        : TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return _ConfiguredTimePicker(
          child: child!,
        );
      },
    );

    return pickedTime;
  }

  /// Отображает пикеры даты и времени в стиле Material.
  /// Обновляет вьюмодель места.
  Future<void> showMaterialToVisitDateTimePickers(
    BuildContext context,
    DateTime? savedToVisitDate,
  ) async {
    final pickedDate = await showMaterialToVisitDatePicker(savedToVisitDate);
    if (pickedDate != null) {
      final pickedTime = await showMaterialToVisitTimePicker(savedToVisitDate);

      final pickedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime?.hour ?? visitingHourByDefault, // По умолчанию.
        pickedTime?.minute ?? 0,
      );

      if (context.mounted) {
        context
            .read<FavouritePlaceCubit>()
            .updateToVisitPlaceDateTime(pickedDateTime);
      }
    }
  }

  /// Отображает пикер даты и времени в стиле Cupertino.
  Future<void> showCupertinoToVisitDateTimePicker(
    BuildContext context,
    DateTime? savedToVisitDate,
  ) {
    return showModalBottomSheet<void>(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      context: context,
      builder: (_) {
        final currentDateTime = DateTime.now();
        final initialDate =
            getPickerInitialDate(currentDateTime, savedToVisitDate);

        return CupertinoDatePicker(
          minimumDate: currentDateTime,
          maximumDate: currentDateTime.add(const Duration(days: 100)),
          initialDateTime: initialDate,
          onDateTimeChanged: (pickedDateTime) => context
              .read<FavouritePlaceCubit>()
              .updateToVisitPlaceDateTime(pickedDateTime),
        );
      },
    );
  }

  /// Возвращает начальную дату для пикера.
  ///
  /// Если дата посещения не задана и она находится в прошлом, то выберем сегодняшнюю.
  DateTime getPickerInitialDate(
    DateTime currentDateTime,
    DateTime? savedToVisitDate,
  ) {
    var initialDate = currentDateTime;
    if (savedToVisitDate != null && savedToVisitDate.isAfter(DateTime.now())) {
      initialDate = savedToVisitDate;
    }

    return initialDate;
  }
}

/// Пикер времени с заданными цветами.
class _ConfiguredTimePicker extends StatelessWidget {
  final Widget child;

  const _ConfiguredTimePicker({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColorDark = theme.primaryColorDark;
    final primaryColor = theme.primaryColor;
    final scaffoldColor = theme.scaffoldBackgroundColor;
    final colorSchemeSecondaryColor = theme.colorScheme.secondary;
    final colorSchemeOnBackgroundColor = theme.colorScheme.onBackground;
    final colorSchemeSecondaryContainerColor =
        theme.colorScheme.secondaryContainer;

    return CustomTimePicker(
      child: child,
      theme: theme,
      colorSchemePrimary: colorSchemeOnBackgroundColor,
      colorSchemeOnSurface: colorSchemeSecondaryContainerColor,
      colorSchemeSurface: colorSchemeSecondaryColor,
      pickerBackGroundColor: scaffoldColor,
      pickerHourMinuteColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? primaryColorDark
              : colorSchemeSecondaryContainerColor),
      pickerHourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? scaffoldColor
              : primaryColor),
      pickerDayPeriodColor: colorSchemeSecondaryColor,
      pickerDialHandColor: primaryColorDark,
      pickerDialBackgroundColor: colorSchemeSecondaryContainerColor,
      pickerDialTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? scaffoldColor
              : primaryColorDark),
      pickerEntryModeIconColor: primaryColorDark,
      textButtonForegroundColor: primaryColorDark,
    );
  }
}

/// Задний фон, когда происходит свайп карточки влево для удаления.
class _BackgroundOnDismiss extends StatelessWidget {
  final bool isDraggingActive;

  const _BackgroundOnDismiss({
    Key? key,
    required this.isDraggingActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return !isDraggingActive
        ? AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: AppColors.flamingo,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(
                right: 16.0,
                bottom: 16.0,
                top: 16.0,
              ),
              margin: const EdgeInsets.only(bottom: 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.delete,
                    width: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      AppStrings.delete,
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
