import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/domain/interactor/favourite_place_interactor.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_place_bloc/favourite_place_event.dart';
import 'package:places/features/place_filters/presentation/bloc/place_filters_bloc.dart';

part 'favourite_place_state.dart';

final class FavouritePlaceBloc
    extends Bloc<FavouritePlaceEvent, FavouritePlaceState> {
  static const _dateUpdateDebounceDuration = Duration(milliseconds: 500);

  final Place _place;
  final FavouritePlaceInteractor _favouritePlaceInteractor;

  FavouritePlaceBloc({
    required Place place,
    required FavouritePlaceInteractor favouritePlaceInteractor,
  })  : _favouritePlaceInteractor = favouritePlaceInteractor,
        _place = place,
        super(FavouritePlaceState(place)) {
    on<FavouritePlaceToVisitPlaceDateTimeUpdated>(
      _onToVisitPlaceDateTimeUpdated,
      transformer: debounce(_dateUpdateDebounceDuration),
    );
  }

  void _onToVisitPlaceDateTimeUpdated(
    FavouritePlaceToVisitPlaceDateTimeUpdated event,
    Emitter<FavouritePlaceState> emit,
  ) =>
      _favouritePlaceInteractor.updateFavouriteDate(_place, event.dateTime);
}
