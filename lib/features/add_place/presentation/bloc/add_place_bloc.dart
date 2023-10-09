import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/add_place/domain/interactor/photo_interactor.dart';
import 'package:places/features/add_place/domain/model/image_source.dart';

part 'add_place_event.dart';

part 'add_place_state.dart';

class AddPlaceBloc extends Bloc<AddPlaceEvent, AddPlaceState> {
  final PlaceInteractor _placeInteractor;
  final PhotoInteractor _photoInteractor;

  /// Тип достопримечательности по умолчанию.
  PlaceTypes get _defaultPlaceType => PlaceTypes.other;

  /// Режим работы места по умолчанию.
  String get _defaultWorkTimeFrom => '9:00';

  AddPlaceBloc({
    required PlaceInteractor placeInteractor,
    required PhotoInteractor photoInteractor,
  })  : _placeInteractor = placeInteractor,
        _photoInteractor = photoInteractor,
        super(AddPlaceInitial()) {
    on<AddPlaceTypeSet>(_onTypeSet);
    on<AddPlacePhotoAdded>(_onPhotoAdded);
    on<AddPlacePhotoDeleted>(_onPhotoDeleted);
    on<AddPlaceFormValidated>(_onFormValidated);
    on<AddPlacePlaceCreated>(_onPlaceCreated);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    Error.throwWithStackTrace(
      error.toString(),
      stackTrace,
    );
  }

  void _onTypeSet(
    AddPlaceTypeSet event,
    Emitter<AddPlaceState> emit,
  ) =>
      emit(
        state.copyWith(
          placeType: event.placeType,
        ),
      );

  Future<void> _onPhotoAdded(
    AddPlacePhotoAdded event,
    Emitter<AddPlaceState> emit,
  ) async {
    final file = await _photoInteractor.pickImage(source: event.source);
    if (file == null) return;

    emit(state.copyWith(photoList: [...state.photoList, file]));
  }

  void _onPhotoDeleted(
    AddPlacePhotoDeleted event,
    Emitter<AddPlaceState> emit,
  ) =>
      emit(
        state.copyWith(
          photoList: [...state.photoList]..removeAt(event.index),
        ),
      );

  void _onFormValidated(
    AddPlaceFormValidated event,
    Emitter<AddPlaceState> emit,
  ) =>
      emit(
        AddPlaceFormValidation(
          photoList: state.photoList,
          placeType: state.placeType,
        ),
      );

  Future<void> _onPlaceCreated(
    AddPlacePlaceCreated event,
    Emitter<AddPlaceState> emit,
  ) async {
    var photoUrlList = <String>[];
    try {
      photoUrlList = await _photoInteractor.uploadImages(state.photoList);
    } on Exception {
      return emit(
        AddPlacePlaceCreationError(
          photoList: state.photoList,
          placeType: state.placeType,
        ),
      );
    }

    final newPlace = Place(
      name: event.name,
      coordinatePoint: CoordinatePoint(
        lat: event.lat,
        lon: event.lon,
      ),
      type: state.placeType ?? _defaultPlaceType,
      details: event.description,
      workTimeFrom: _defaultWorkTimeFrom,
      photoUrlList: photoUrlList,
    );

    try {
      await _placeInteractor.addNewPlace(newPlace);

      emit(
        AddPlacePlaceCreation(),
      );
    } on Exception {
      emit(
        AddPlacePlaceCreationError(
          photoList: state.photoList,
          placeType: state.placeType,
        ),
      );
    }
  }
}
