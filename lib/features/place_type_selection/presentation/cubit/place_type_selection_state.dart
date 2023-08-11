part of 'place_type_selection_cubit.dart';

final class PlaceTypeSelectionState {
  final PlaceTypes? placeType;

  const PlaceTypeSelectionState({
    this.placeType,
  });

  PlaceTypeSelectionState copyWith({
    PlaceTypes? placeType,
  }) {
    return PlaceTypeSelectionState(
      placeType: placeType ?? this.placeType,
    );
  }
}
