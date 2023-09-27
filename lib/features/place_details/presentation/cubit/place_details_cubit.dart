import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/domain/interactor/favourite_place_interactor.dart';

part 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  final PlaceInteractor _placeInteractor;
  final FavouritePlaceInteractor _favouritePlaceInteractor;
  late final StreamSubscription<List<Place>> _favouritesStreamSubscription;

  PlaceDetailsCubit({
    required PlaceInteractor placeInteractor,
    required FavouritePlaceInteractor favouritePlaceInteractor,
    required Place initialPlace,
  })  : _placeInteractor = placeInteractor,
        _favouritePlaceInteractor = favouritePlaceInteractor,
        super(
          PlaceDetailsInitial(place: initialPlace),
        );

  @override
  Future<void> close() {
    _favouritesStreamSubscription.cancel();
    return super.close();
  }

  /// Подписка на избранное для обновления экрана.
  Future<void> subscribeToFavourites() async {
    _favouritesStreamSubscription =
        _favouritePlaceInteractor.getFavourites().listen((favourites) {
      Place place;
      if (favourites.contains(state.place)) {
        place = state.place..isFavorite = true;
      } else {
        place = state.place..isFavorite = false;
      }

      emit(PlaceDetailsLoadSuccess(place: place));
    });
  }

  /// Получает детальную информацию места.
  Future<void> loadPlaceDetails(int placeId) async {
    emit(
      PlaceDetailsLoadInProgress(
        place: state.place,
      ),
    );

    try {
      final place = await _placeInteractor.getPlaceDetails(placeId);

      emit(
        PlaceDetailsLoadSuccess(place: place),
      );
    } on Exception catch (error, stackTrace) {
      emit(
        PlaceDetailsLoadFailure(place: state.place),
      );

      Error.throwWithStackTrace(
        error.toString(),
        stackTrace,
      );
    }
  }
}
