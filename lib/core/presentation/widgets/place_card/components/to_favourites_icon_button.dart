import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/presentation/widgets/place_card/cubit/place_card_favourite_cubit.dart';

class ToFavouritesIconButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback toggleFavorites;
  final Color? color;

  const ToFavouritesIconButton({
    super.key,
    required this.isFavorite,
    required this.toggleFavorites,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaceCardFavouriteCubit(
        initialValue: isFavorite,
        toggleFavoritesCallback: toggleFavorites,
      ),
      child: BlocBuilder<PlaceCardFavouriteCubit, PlaceCardFavouriteState>(
        builder: (context, state) {
          return InkWell(
            splashFactory: NoSplash.splashFactory,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: SvgPicture.asset(
                state.isFavourite ? AppAssets.heartFilled : AppAssets.heart,
                key: ValueKey(state.isFavourite),
                colorFilter: color != null
                    ? ColorFilter.mode(
                        color!,
                        BlendMode.srcIn,
                      )
                    : null,
              ),
            ),
            onTap: () =>
                context.read<PlaceCardFavouriteCubit>().toggleFavorites(),
          );
        },
      ),
    );
  }
}
