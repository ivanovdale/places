import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/features/favourite_places/data/favourite_place_interactor.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_state.dart';

final class FavouritePlacesBloc
    extends Bloc<FavouritePlacesEvent, FavouritePlacesState> {
  final FavouritePlaceInteractor _favouritePlaceInteractor;

  FavouritePlacesBloc(this._favouritePlaceInteractor)
      : super(FavouritePlacesState()) {
    on(_onFavouritePlacesStarted);
    on(_onFavouritePlacesToFavouritesPressed);
    on(_onFavouritePlacesPlaceInserted);
  }

  Future<void> _onFavouritePlacesStarted(
    FavouritePlacesStarted event,
    Emitter<FavouritePlacesState> emit,
  ) async {
    // Имитация загрузки.
    await Future<void>.delayed(const Duration(seconds: 3));

    emit(
      FavouritePlacesState(
        places: _favouritePlaceInteractor.getPlaces(),
        status: FavouritePlacesStatus.success,
      ),
    );
  }

  void _onFavouritePlacesToFavouritesPressed(
    FavouritePlacesToFavouritesPressed event,
    Emitter<FavouritePlacesState> emit,
  ) {
    final places = _favouritePlaceInteractor.toggleFavourite(event.place);

    emit(
      state.copyWith(
        places: places,
      ),
    );
  }

  void _onFavouritePlacesPlaceInserted(
    FavouritePlacesPlaceInserted event,
    Emitter<FavouritePlacesState> emit,
  ) {
    final places = _favouritePlaceInteractor.insertPlace(
      event.place,
      event.targetPlace,
    );

    emit(
      state.copyWith(
        places: places,
      ),
    );
  }
}
