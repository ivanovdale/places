import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';

part 'chosen_place_state.dart';

class ChosenPlaceCubit extends Cubit<ChosenPlaceState> {
  ChosenPlaceCubit() : super(const ChosenPlaceState());

  void updateChosenPlace(Place place) => emit(
        state.copyWith(
          place: place,
          isPlaceChosen: true,
          isPlaceLayerHidden: false,
        ),
      );

  void resetChosenPlace() => emit(state.copyWith(isPlaceChosen: false));

  void hidePlaceLayer() => emit(state.copyWith(isPlaceLayerHidden: true));
}
