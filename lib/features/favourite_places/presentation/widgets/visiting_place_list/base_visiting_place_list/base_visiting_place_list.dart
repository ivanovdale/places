import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/custom_pickers/utils/custom_date_time_picker_helper.dart';
import 'package:places/core/presentation/widgets/place_card/base_place_card.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_place_cubit/favourite_place_cubit.dart';
import 'package:places/features/favourite_places/presentation/widgets/cards/components/draggable_place_card_with_drag_target_option.dart';
import 'package:places/features/favourite_places/presentation/widgets/cards/to_visit_place_card.dart';
import 'package:places/features/favourite_places/presentation/widgets/cards/visited_place_card.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/base_visiting_place_list/components/background_on_dismiss.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/to_visit_place_list.dart';

typedef OnPlaceInserted = void Function(Place, Place);
typedef OnPlaceDeleted = void Function(Place);

/// Абстрактный класс [BaseVisitingPlaceList]. Список посещенных/планируемых к посещению мест.
///
/// Если список пуст, будет отображена соответствующая информация ([emptyVisitingList]).
///
/// Имеет поля, которые необходимо переопределить в потомках:
/// * [emptyVisitingList] - виджет для отображения пустого списка.
///
/// Имеет параметры
/// * [listOfPlaces] - список мест.
abstract class BaseVisitingPlaceList extends StatefulWidget {
  final List<Place> listOfPlaces;
  abstract final WidgetBuilder emptyVisitingList;

  final OnPlaceInserted? onPlaceInserted;
  final OnPlaceDeleted? onPlaceDeleted;

  const BaseVisitingPlaceList({
    Key? key,
    required this.listOfPlaces,
    this.onPlaceInserted,
    this.onPlaceDeleted,
  }) : super(key: key);

  @override
  State<BaseVisitingPlaceList> createState() => _BaseVisitingPlaceListState();
}

/// Состояние списка мест.
///
/// Содержит в себе скролл-контроллер для прокрутки списка в момент перетаскивания места.
class _BaseVisitingPlaceListState extends State<BaseVisitingPlaceList> {
  final ScrollController _scrollController = ScrollController();
  bool _isDragged = false;

  /// Устанавливает состояние - началось перетаскивание элемента.
  void _onDragStarted() {
    setState(() {
      _isDragged = true;
    });
  }

  /// Устанавливает состояние - завершилось перетаскивание элемента.
  void _onDragEnd() {
    setState(() {
      _isDragged = false;
    });
  }

  /// Делает скролл вверх или вниз в зависимости от того, в какую область перетаскивается карточка места.
  void _scrollPlaceCardsWhenCardDragged(PointerMoveEvent event) {
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

  /// Возвращает карточку места в зависимости от типа поля placeCardType.
  BasePlaceCard _getPlaceCard(BuildContext context, Place place) {
    final widget = this.widget;

    return widget is ToVisitPlaceList
        ? ToVisitPlaceCard(
            place,
            key: ObjectKey(place),
            onDeletePressed: () => widget.onPlaceDeleted?.call(place),
            onCalendarPressed: () =>
                CustomDateTimePickerHelper.showDateTimePicker(
              context,
              place,
              (pickedDateTime) =>
                  widget.onPlaceDateTimePicked.call(context, pickedDateTime),
            ),
          )
        : VisitedPlaceCard(
            place,
            key: ObjectKey(place),
            // TODO(daniiliv): Вызов реальной функции.
            onSharePressed: () {},
            onDeletePressed: (place) => widget.onPlaceDeleted?.call(place),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext _) {
    final listOfPlaces = widget.listOfPlaces;

    return listOfPlaces.isEmpty
        ? Builder(builder: widget.emptyVisitingList)
        : ListView.builder(
            controller: _scrollController,
            itemCount: listOfPlaces.length,
            itemBuilder: (_, index) {
              final place = listOfPlaces[index];

              return Stack(
                children: [
                  BackgroundOnDismiss(
                    isDraggingActive: _isDragged,
                  ),
                  Dismissible(
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) =>
                        widget.onPlaceDeleted?.call(place),
                    key: ObjectKey(place),
                    child: BlocProvider(
                      create: (_) => FavouritePlaceCubit(place),
                      child:
                          BlocBuilder<FavouritePlaceCubit, FavouritePlaceState>(
                        builder: (context, state) {
                          final placeCard = _getPlaceCard(context, place);
                          final currentPlace = state.place;

                          return DraggablePlaceCardWithDragTargetOption(
                            index: index,
                            place: currentPlace,
                            placeCard: placeCard,
                            isDragged: _isDragged,
                            onDragStarted: _onDragStarted,
                            onDragEnd: (details) => _onDragEnd(),
                            onAccept: (data) => widget.onPlaceInserted
                                ?.call(data, currentPlace),
                            scrollPlaceCardsWhenCardDragged:
                                _scrollPlaceCardsWhenCardDragged,
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
}
