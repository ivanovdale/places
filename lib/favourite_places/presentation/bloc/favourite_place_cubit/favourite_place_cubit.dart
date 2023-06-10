import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/domain/model/place.dart';

part 'favourite_place_state.dart';

final class FavouritePlaceCubit extends Cubit<FavouritePlaceState> {
  FavouritePlaceCubit(Place place) : super(FavouritePlaceState(place));

  void updateToVisitPlaceDateTime(DateTime dateTime) {
    final placeWithNewDate = state.place..visitDate = dateTime;
    final newState = state.copyWith(place: placeWithNewDate);

    emit(newState);
  }
}
