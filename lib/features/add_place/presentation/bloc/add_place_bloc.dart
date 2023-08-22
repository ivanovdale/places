import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/mocks.dart' as mocked;

part 'add_place_event.dart';

part 'add_place_state.dart';

class AddPlaceBloc extends Bloc<AddPlaceEvent, AddPlaceState> {
  final PlaceInteractor _placeInteractor;

  /// Тип достопримечательности по умолчанию.
  PlaceTypes get _defaultPlaceType => PlaceTypes.other;

  /// Режим работы места по умолчанию.
  String get _defaultWorkTimeFrom => '9:00';

  AddPlaceBloc(this._placeInteractor) : super(AddPlaceInitial()) {
    on(_onAddPlaceStarted);
    on(_onAddPlaceTypeSet);
    on(_onAddPlacePhotoAdded);
    on(_onAddPlacePhotoDeleted);
    on(_onAddPlaceFormValidated);
    on(_onAddPlacePlaceCreated);
  }

  void _onAddPlaceStarted(
    AddPlaceStarted event,
    Emitter<AddPlaceState> emit,
  ) {
    final newState = AddPlaceInitial(
      photoList: mocked.photoCarouselOnAddPlaceScreen,
    );

    emit(newState);
  }

  void _onAddPlaceTypeSet(
    AddPlaceTypeSet event,
    Emitter<AddPlaceState> emit,
  ) {
    final newState = state.copyWith(
      placeType: event.placeType,
    );

    emit(newState);
  }

  void _onAddPlacePhotoAdded(
    AddPlacePhotoAdded event,
    Emitter<AddPlaceState> emit,
  ) {
    final newState = state.copyWith(
      photoList: [...state.photoList, event.photoUrl],
    );

    emit(newState);
  }

  void _onAddPlacePhotoDeleted(
    AddPlacePhotoDeleted event,
    Emitter<AddPlaceState> emit,
  ) {
    final newState = state.copyWith(
      photoList: [...state.photoList]..removeAt(event.index),
    );

    emit(newState);
  }

  void _onAddPlaceFormValidated(
    AddPlaceFormValidated event,
    Emitter<AddPlaceState> emit,
  ) {
    final newState = AddPlaceFormValidation(
      photoList: state.photoList,
      placeType: state.placeType,
    );

    emit(newState);
  }

  Future<void> _onAddPlacePlaceCreated(
    AddPlacePlaceCreated event,
    Emitter<AddPlaceState> emit,
  ) async {
    final newPlace = Place(
      name: event.name,
      coordinatePoint: CoordinatePoint(
        lat: event.lat,
        lon: event.lon,
      ),
      type: state.placeType ?? _defaultPlaceType,
      details: event.description,
      workTimeFrom: _defaultWorkTimeFrom,
      photoUrlList: state.photoList,
    );

    try {
      await _placeInteractor.addNewPlace(newPlace);

      emit(
        AddPlacePlaceCreation(),
      );
    } on Exception catch (error, stackTrace) {
      emit(
        AddPlacePlaceCreationError(
          photoList: state.photoList,
          placeType: state.placeType,
        ),
      );

      Error.throwWithStackTrace(
        error.toString(),
        stackTrace,
      );
    }
  }
}
