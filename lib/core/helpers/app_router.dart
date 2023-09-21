import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/features/favourite_places/presentation/favourite_places_screen.dart';
import 'package:places/features/on_boarding/presentation/on_boarding_screen.dart';
import 'package:places/features/place_details/presentation/place_details_screen.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';
import 'package:places/features/place_filters/presentation/place_filters_screen.dart';
import 'package:places/features/place_list/presentation/place_list_screen.dart';
import 'package:places/features/place_search/presentation/place_search_screen.dart';
import 'package:places/features/place_type_selection/presentation/place_type_selection_screen.dart';
import 'package:places/features/settings/presentation/settings_screen.dart';
import 'package:places/features/splash_screen/presentation/splash_screen.dart';

/// Роутер для именованных роутов.
abstract final class AppRouter {
  /// Начальный экран (Сплэш-скрин).
  static const String root = '/';

  /// Экран онбординга.
  static const String onBoarding = '/onBoarding';

  /// Экран списка мест.
  static const String placeList = '/placeList';

  /// Экран поиска мест.
  static const String placeSearch = '/placeSearch';

  /// Экран выбора фильтров мест.
  static const String placeFilters = '/placeFilters';

  /// Экран для добавления нового места.
  static const String addPlace = '/addPlace';

  /// Экран выбора категории места.
  static const String placeTypeSelection = '/placeTypeSelection';

  /// Экран подробностей места.
  static const String placeDetails = '/placeDetails';

  /// Экран списка посещенных/планируемых к посещению мест.
  static const String favouritePlaces = '/favouritePlaces';

  /// Экран настроек.
  static const String settings = '/settings';

  /// Коллбэк, используемый при навигации через именованный роут.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case AppRouter.onBoarding:
        return _getOnBoardingMaterialRoute();
      case AppRouter.placeList:
        return _getPlaceListMaterialRoute();
      case AppRouter.placeSearch:
        return _getPlaceSearchMaterialRoute(arguments);
      case AppRouter.placeFilters:
        return _getPlaceFiltersMaterialRoute(arguments);
      case AppRouter.addPlace:
        return _getAddPlaceMaterialRoute();
      case AppRouter.placeTypeSelection:
        return _getPlaceTypeSelectionMaterialRoute(arguments);
      case AppRouter.placeDetails:
        return _getPlaceDetailsMaterialRoute(arguments);
      case AppRouter.favouritePlaces:
        return _getFavouritePlacesMaterialRoute();
      case AppRouter.settings:
        return _getSettingsMaterialRoute();
      case AppRouter.root:
      default:
        return _getSplashMaterialRoute();
    }
  }

  static MaterialPageRoute<Object?> _getSplashMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const SplashScreen(),
    );
  }

  static MaterialPageRoute<Object?> _getOnBoardingMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const OnBoardingScreen(),
    );
  }

  static MaterialPageRoute<Object?> _getPlaceListMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const PlaceListScreen(),
    );
  }

  static MaterialPageRoute<Object?> _getPlaceSearchMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    return MaterialPageRoute<Object?>(
      builder: (_) => const PlaceSearchScreen(),
    );
  }

  static MaterialPageRoute<PlaceFilters?> _getPlaceFiltersMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    return MaterialPageRoute<PlaceFilters>(
      builder: (_) => const PlaceFiltersScreen(),
    );
  }

  static MaterialPageRoute<bool> _getAddPlaceMaterialRoute() {
    return MaterialPageRoute<bool>(
      builder: (_) => const AddPlaceScreen(),
    );
  }

  static MaterialPageRoute<PlaceTypes> _getPlaceTypeSelectionMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    final placeType = arguments?['placeType'] as PlaceTypes?;

    return MaterialPageRoute<PlaceTypes>(
      builder: (_) => PlaceTypeSelectionScreen(placeType: placeType),
    );
  }

  static MaterialPageRoute<Object?> _getPlaceDetailsMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    final place = arguments!['place'] as Place;
    final isBottomSheet = arguments['isBottomSheet'] as bool;

    return MaterialPageRoute<Object?>(
      builder: (_) => PlaceDetailsScreen(
        place,
        isBottomSheet: isBottomSheet,
      ),
    );
  }

  static MaterialPageRoute<Object?> _getFavouritePlacesMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const FavouritePlacesScreen(),
    );
  }

  static MaterialPageRoute<Object?> _getSettingsMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const SettingsScreen(),
    );
  }
}
