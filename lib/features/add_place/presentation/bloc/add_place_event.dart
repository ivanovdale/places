part of 'add_place_bloc.dart';

sealed class AddPlaceEvent {}

final class AddPlaceStarted extends AddPlaceEvent {}

final class AddPlaceTypeSet extends AddPlaceEvent {
  final PlaceTypes placeType;

  AddPlaceTypeSet({
    required this.placeType,
  });
}

final class AddPlacePhotoAdded extends AddPlaceEvent {
  final String photoUrl;

  AddPlacePhotoAdded({
    required this.photoUrl,
  });
}

final class AddPlacePhotoDeleted extends AddPlaceEvent {
  final int index;

  AddPlacePhotoDeleted({
    required this.index,
  });
}

final class AddPlaceFormValidated extends AddPlaceEvent {}

final class AddPlacePlaceCreated extends AddPlaceEvent {
  final String name;
  final double lat;
  final double lon;
  final String description;

  AddPlacePlaceCreated({
    required this.name,
    required this.lat,
    required this.lon,
    required this.description,
  });
}
