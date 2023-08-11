import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'place_card_favourite_state.dart';

class PlaceCardFavouriteCubit extends Cubit<PlaceCardFavouriteState> {
  final bool initialValue;
  final VoidCallback toggleFavoritesCallback;

  PlaceCardFavouriteCubit({
    required this.initialValue,
    required this.toggleFavoritesCallback,
  }) : super(
          PlaceCardFavouriteState(
            isFavourite: initialValue,
          ),
        );

  /// Переключение кнопки "Добавить в избранное" / "Убрать из избранного".
  void toggleFavorites() {
    toggleFavoritesCallback();

    emit(
      state.copyWith(
        isFavourite: !state.isFavourite,
      ),
    );
  }
}
