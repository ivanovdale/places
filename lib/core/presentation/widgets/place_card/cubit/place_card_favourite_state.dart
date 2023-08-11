part of 'place_card_favourite_cubit.dart';

final class PlaceCardFavouriteState {
  final bool isFavourite;

  const PlaceCardFavouriteState({
    required this.isFavourite,
  });

  PlaceCardFavouriteState copyWith({
    bool? isFavourite,
  }) {
    return PlaceCardFavouriteState(
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
