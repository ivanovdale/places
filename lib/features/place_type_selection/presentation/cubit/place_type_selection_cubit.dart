import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/domain/model/place.dart';

part 'place_type_selection_state.dart';

class PlaceTypeSelectionCubit extends Cubit<PlaceTypeSelectionState> {
  PlaceTypeSelectionCubit(PlaceTypes? initialPlaceType)
      : super(
          PlaceTypeSelectionState(
            placeType: initialPlaceType,
          ),
        );

  void setCurrentPlaceType(PlaceTypes? placeType) {
    emit(
      state.copyWith(
        placeType: placeType,
      ),
    );
  }
}
