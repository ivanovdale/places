part of 'chosen_place_cubit.dart';

class ChosenPlaceState {
  final Place? place;
  final bool isPlaceChosen;

  const ChosenPlaceState({
    this.place,
    this.isPlaceChosen = false,
  });

  ChosenPlaceState copyWith({
    Place? place,
    bool? isPlaceChosen,
  }) {
    return ChosenPlaceState(
      place: place ?? this.place,
      isPlaceChosen: isPlaceChosen ?? this.isPlaceChosen,
    );
  }
}
