import 'package:flutter/material.dart';
import 'package:places/UI/screens/add_sight_screen.dart';
import 'package:places/UI/screens/onboarding_screen.dart';
import 'package:places/UI/screens/settings_screen.dart';
import 'package:places/UI/screens/sight_details_screen.dart';
import 'package:places/UI/screens/sight_filters_screen.dart';
import 'package:places/UI/screens/sight_list_screen.dart';
import 'package:places/UI/screens/sight_search_screen.dart';
import 'package:places/UI/screens/sight_type_selection_screen.dart';
import 'package:places/UI/screens/splash_screen.dart';
import 'package:places/UI/screens/visiting_sights_screen.dart';
import 'package:places/data/model/sight.dart';

/// Роутер для именованных роутов.
abstract class AppRouter {
  /// Начальный экран (Сплэш-скрин).
  static const String root = '/';

  /// Экран онбординга.
  static const String onboarding = '/onboarding';

  /// Экран списка достопримечательностей.
  static const String sightList = '/sightList';

  /// Экран поиска достопримечательностей.
  static const String sightSearch = '/sightSearch';

  /// Экран выбора фильтров достопримечательностей.
  static const String sightFilters = '/sightFilters';

  /// Экран для добавления новой достопримечательности.
  static const String addSight = '/addSight';

  /// Экран выбора категории достопримечательности.
  static const String sightTypeSelection = '/sightTypeSelection';

  /// Экран подробностей достопримечательности.
  static const String sightDetails = '/sightDetails';

  /// Экран списка посещенных/планируемых к посещению мест.
  static const String visitingSights = '/visitingSights';

  /// Экран настроек.
  static const String settings = '/settings';

  /// Коллбэк, используемый при навигации через именованный роут.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case AppRouter.onboarding:
        return _getOnboardingMaterialRoute();
      case AppRouter.sightList:
        return _getSightListMaterialRoute();
      case AppRouter.sightSearch:
        return _getSightSearchMaterialRoute(arguments);
      case AppRouter.sightFilters:
        return _getSightFiltersMaterialRoute(arguments);
      case AppRouter.addSight:
        return _getAddSightMaterialRoute();
      case AppRouter.sightTypeSelection:
        return _getSightTypeSelectionMaterialRoute();
      case AppRouter.sightDetails:
        return _getSightDetailsMaterialRoute(arguments);
      case AppRouter.visitingSights:
        return _getVisitingSightsMaterialRoute();
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

  static MaterialPageRoute<Object?> _getSightListMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const SightListScreen(),
    );
  }

  static MaterialPageRoute<Object?> _getSightSearchMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    final allFilters = _parseSightFilters(arguments);

    return MaterialPageRoute<Object?>(
      builder: (_) => SightSearchScreen(
        sightTypeFilters:
            allFilters['sightTypeFilters'] as List<Map<String, Object>>,
        distanceFrom: allFilters['distanceFrom'] as double,
        distanceTo: allFilters['distanceTo'] as double,
      ),
    );
  }

  static MaterialPageRoute<Map<String, Object>> _getSightFiltersMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    final allFilters = _parseSightFilters(arguments);

    return MaterialPageRoute<Map<String, Object>>(
      builder: (_) => SightFiltersScreen(
        sightTypeFilters:
            allFilters['sightTypeFilters'] as List<Map<String, Object>>,
        distanceFrom: allFilters['distanceFrom'] as double,
        distanceTo: allFilters['distanceTo'] as double,
      ),
    );
  }

  static Map<String, dynamic> _parseSightFilters(
    Map<String, dynamic>? arguments,
  ) {
    final allFilters = {
      'sightTypeFilters':
          arguments!['sightTypeFilters'] as List<Map<String, Object>>,
      'distanceFrom': arguments['distanceFrom'] as double,
      'distanceTo': arguments['distanceTo'] as double,
    };

    return allFilters;
  }

  static MaterialPageRoute<Sight?> _getAddSightMaterialRoute() {
    return MaterialPageRoute<Sight?>(
      builder: (_) => const AddSightScreen(),
    );
  }

  static MaterialPageRoute<SightTypes> _getSightTypeSelectionMaterialRoute() {
    return MaterialPageRoute<SightTypes>(
      builder: (_) => const SightTypeSelectionScreen(),
    );
  }

  static MaterialPageRoute<Object?> _getSightDetailsMaterialRoute(
    Map<String, dynamic>? arguments,
  ) {
    final id = arguments!['id'] as int;

    return MaterialPageRoute<Object?>(
      builder: (_) => SightDetailsScreen(id),
    );
  }

  static MaterialPageRoute<Object?> _getVisitingSightsMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const VisitingSightsScreen(),
    );
  }

  static MaterialPageRoute<Object?> _getSettingsMaterialRoute() {
    return MaterialPageRoute<Object?>(
      builder: (_) => const SettingsScreen(),
    );
  }
}
