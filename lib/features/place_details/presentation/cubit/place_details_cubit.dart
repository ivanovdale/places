import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/model/place.dart';

part 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  final PlaceInteractor _placeInteractor;

  PlaceDetailsCubit(
    this._placeInteractor,
    Place _initialPlace,
  ) : super(
          PlaceDetailsInitial(place: _initialPlace),
        );

  /// Получает детальную информацию места.
  Future<void> loadPlaceDetails(int placeId) async {
    emit(
      PlaceDetailsLoadInProgress(
        place: state.place,
      ),
    );

    try {
      final place = await _placeInteractor.getPlaceDetails(placeId);

      emit(
        PlaceDetailsLoadSuccess(place: place),
      );
    } on Exception catch (error, stackTrace) {
      emit(
        PlaceDetailsLoadFailure(place: state.place),
      );

      Error.throwWithStackTrace(
        error.toString(),
        stackTrace,
      );
    }
  }
}
