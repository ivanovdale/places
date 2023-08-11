part of 'add_place_bloc.dart';

sealed class AddPlaceState {
  final List<String> photoList;
  final PlaceTypes? placeType;

  const AddPlaceState({
    required this.photoList,
    this.placeType,
  });

  AddPlaceState copyWith({
    List<String>? photoList,
    PlaceTypes? placeType,
  });
}

final class AddPlaceInitial extends AddPlaceState {
  AddPlaceInitial({
    super.photoList = const [],
    super.placeType,
  });

  @override
  AddPlaceState copyWith({
    List<String>? photoList,
    PlaceTypes? placeType,
  }) {
    return AddPlaceInitial(
      photoList: photoList ?? this.photoList,
      placeType: placeType ?? this.placeType,
    );
  }
}

final class AddPlaceFormValidation extends AddPlaceState {
  AddPlaceFormValidation({
    required super.photoList,
    required super.placeType,
  });

  @override
  AddPlaceState copyWith({
    List<String>? photoList,
    PlaceTypes? placeType,
  }) {
    return AddPlaceFormValidation(
      photoList: photoList ?? this.photoList,
      placeType: placeType ?? this.placeType,
    );
  }
}

final class AddPlacePlaceCreation extends AddPlaceState {
  AddPlacePlaceCreation({
    super.photoList = const [],
    super.placeType,
  });

  @override
  AddPlaceState copyWith({
    List<String>? photoList,
    PlaceTypes? placeType,
  }) {
    return AddPlacePlaceCreation(
      photoList: photoList ?? this.photoList,
      placeType: placeType ?? this.placeType,
    );
  }
}

final class AddPlacePlaceCreationError extends AddPlaceState {
  AddPlacePlaceCreationError({
    super.photoList = const [],
    super.placeType,
  });

  @override
  AddPlaceState copyWith({
    List<String>? photoList,
    PlaceTypes? placeType,
  }) {
    return AddPlacePlaceCreationError(
      photoList: photoList ?? this.photoList,
      placeType: placeType ?? this.placeType,
    );
  }
}
