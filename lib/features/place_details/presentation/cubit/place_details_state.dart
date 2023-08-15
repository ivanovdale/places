part of 'place_details_cubit.dart';

sealed class PlaceDetailsState {
  final Place place;

  PlaceDetailsState({
    required this.place,
  });
}

final class PlaceDetailsInitial extends PlaceDetailsState {
  PlaceDetailsInitial({
    required super.place,
  });
}

final class PlaceDetailsLoadInProgress extends PlaceDetailsState {
  PlaceDetailsLoadInProgress({
    required super.place,
  });
}

final class PlaceDetailsLoadSuccess extends PlaceDetailsState {
  PlaceDetailsLoadSuccess({
    required super.place,
  });
}

final class PlaceDetailsLoadFailure extends PlaceDetailsState {
  PlaceDetailsLoadFailure({required super.place});
}
