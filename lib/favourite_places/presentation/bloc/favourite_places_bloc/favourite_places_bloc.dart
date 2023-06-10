import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/favourite_places/data/favourite_place_interactor.dart';
import 'package:places/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_state.dart';


final class FavouritePlacesBloc
    extends Bloc<FavouritePlacesEvent, FavouritePlacesState> {
  final FavouritePlaceInteractor favouritePlaceInteractor;

  FavouritePlacesBloc(this.favouritePlaceInteractor)
      : super(FavouritePlacesState()) {
    on(_onInitialize);
    on(_onToggleFavourites);
    on(_onRemoveFromFavourites);
    on(_onInsertPlace);
  }

  Future<void> _onInitialize(
    FavoritePlacesInitEvent event,
    Emitter<FavouritePlacesState> emit,
  ) async {
    // Имитация загрузки.
    await Future<void>.delayed(const Duration(seconds: 1));

    emit(
      FavouritePlacesState(
        places: favouritePlaceInteractor.getPlaces(),
        status: FavouritePlacesStatus.success,
      ),
    );
  }

  void _onToggleFavourites(
    ToggleFavouritesEvent event,
    Emitter<FavouritePlacesState> emit,
  ) {
    final places = favouritePlaceInteractor.toggleFavourite(event.place);

    emit(
      state.copyWith(
        places: places,
      ),
    );
  }

  void _onRemoveFromFavourites(
    RemoveFromFavouritesEvent event,
    Emitter<FavouritePlacesState> emit,
  ) {
    final places = favouritePlaceInteractor.removeFromFavourites(event.place);

    emit(
      state.copyWith(
        places: places,
      ),
    );
  }

  void _onInsertPlace(
    InsertPlaceEvent event,
    Emitter<FavouritePlacesState> emit,
  ) {
    final places = favouritePlaceInteractor.insertPlace(
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
