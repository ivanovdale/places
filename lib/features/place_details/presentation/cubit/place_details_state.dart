part of 'place_details_cubit.dart';

sealed class PlaceDetailsState {}

final class PlaceDetailsInitial extends PlaceDetailsState {}

final class PlaceDetailsLoadInProgress extends PlaceDetailsState {}

final class PlaceDetailsLoadSuccess extends PlaceDetailsState {
  final Place place;

  PlaceDetailsLoadSuccess({
    required this.place,
  });
}

final class PlaceDetailsLoadFailure extends PlaceDetailsState {}
