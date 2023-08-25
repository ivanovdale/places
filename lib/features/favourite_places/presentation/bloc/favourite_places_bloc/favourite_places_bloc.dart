import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/features/favourite_places/domain/interactor/favourite_place_interactor.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_state.dart';

final class FavouritePlacesBloc
    extends Bloc<FavouritePlacesEvent, FavouritePlacesState> {
  final FavouritePlaceInteractor _favouritePlaceInteractor;

  FavouritePlacesBloc(this._favouritePlaceInteractor)
      : super(FavouritePlacesState()) {
    on<FavouritePlacesSubscriptionRequested>(_onSubscriptionRequested);
    on<FavouritePlacesToFavouritesPressed>(_onToFavouritesPressed);
    on<FavouritePlacesPlaceInserted>(_onPlaceInserted);
  }

  void _onSubscriptionRequested(
    FavouritePlacesSubscriptionRequested event,
    Emitter<FavouritePlacesState> emit,
  ) =>
      emit.forEach(
        _favouritePlaceInteractor.getFavourites(),
        onData: (favourites) => state.copyWith(
          favourites: favourites,
          status: FavouritePlacesStatus.success,
        ),
      );

  void _onToFavouritesPressed(
    FavouritePlacesToFavouritesPressed event,
    Emitter<FavouritePlacesState> emit,
  ) =>
      _favouritePlaceInteractor.toggleFavourite(event.place);

  void _onPlaceInserted(
    FavouritePlacesPlaceInserted event,
    Emitter<FavouritePlacesState> emit,
  ) =>
      _favouritePlaceInteractor.swapFavouritePosition(
        event.place,
        event.targetPlace,
      );
}
