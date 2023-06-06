import 'package:flutter/material.dart';
import 'package:places/UI/screens/add_place_screen.dart';
import 'package:places/UI/screens/onboarding_screen.dart';
import 'package:places/UI/screens/place_details_screen.dart';
import 'package:places/UI/screens/place_filters_screen.dart';
import 'package:places/UI/screens/place_list_screen.dart';
import 'package:places/place_search/place_search_screen.dart';
import 'package:places/UI/screens/place_type_selection_screen.dart';
import 'package:places/UI/screens/settings_screen.dart';
import 'package:places/UI/screens/splash_screen.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/favourite_places/view/favourite_places_screen.dart';

/// Роутер для именованных роутов.
abstract class AppRouter {
  /// Начальный экран (Сплэш-скрин).
  static const String root = '/';

  /// Экран онбординга.
  static const String onboarding = '/onboarding';

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
  static const String visitingPlaces = '/visitingPlaces';

  /// Экран настроек.
  static const String settings = '/settings';

  /// Коллбэк, используемый при навигации через именованный роут.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case AppRouter.onboarding:
        return _getOnboardingMaterialRoute();
      case AppRouter.placeList:
        return _getPlaceListMaterialRoute();
      case AppRouter.placeSearch:
        return _getPlaceSearchMaterialRoute(arguments);
      case AppRouter.placeFilters:
        return _getPlaceFiltersMaterialRoute(arguments);
      case AppRouter.addPlace:
        return _getAddPlaceMaterialRoute();
      case AppRouter.placeTypeSelection:
        return _getPlaceTypeSelectionMaterialRoute();
      case AppRouter.placeDetails:
        return _getPlaceDetailsMaterialRoute(arguments);
      case AppRouter.visitingPlaces:
        return _getVisitingPlacesMaterialRoute();
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

  static MaterialPageRoute<Object?> _getOnboardingMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const OnboardingScreen(),
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
      builder: (_) => PlaceSearchScreen(
        placeTypeFilters: arguments!['placeTypeFilters'] as Set<PlaceTypes>,
        radius: arguments['radius'] as double,
      ),
    );
  }

  static MaterialPageRoute<Map<String, Object>> _getPlaceFiltersMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    return MaterialPageRoute<Map<String, Object>>(
      builder: (_) => PlaceFiltersScreen(
        selectedPlaceTypeFilters:
            arguments!['placeTypeFilters'] as Set<PlaceTypes>,
        radius: arguments['radius'] as double,
      ),
    );
  }

  static MaterialPageRoute<Place?> _getAddPlaceMaterialRoute() {
    return MaterialPageRoute<Place?>(
      builder: (_) => const AddPlaceScreen(),
    );
  }

  static MaterialPageRoute<PlaceTypes> _getPlaceTypeSelectionMaterialRoute() {
    return MaterialPageRoute<PlaceTypes>(
      builder: (_) => const PlaceTypeSelectionScreen(),
    );
  }

  static MaterialPageRoute<Object?> _getPlaceDetailsMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    final id = arguments!['id'] as int;

    return MaterialPageRoute<Object?>(
      builder: (_) => PlaceDetailsScreen(id),
    );
  }

  static MaterialPageRoute<Object?> _getVisitingPlacesMaterialRoute() {
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
