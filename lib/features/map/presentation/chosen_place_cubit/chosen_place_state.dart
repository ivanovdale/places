part of 'chosen_place_cubit.dart';

class ChosenPlaceState {
  final Place? place;
  final bool isPlaceChosen;
  final bool isPlaceLayerHidden;

  const ChosenPlaceState({
    this.place,
    this.isPlaceChosen = false,
    this.isPlaceLayerHidden = false,
  });

  ChosenPlaceState copyWith({
    Place? place,
    bool? isPlaceChosen,
    bool? isPlaceLayerHidden,
  }) {
    return ChosenPlaceState(
      place: place ?? this.place,
      isPlaceChosen: isPlaceChosen ?? this.isPlaceChosen,
      isPlaceLayerHidden: isPlaceLayerHidden ?? this.isPlaceLayerHidden,
    );
  }
}
