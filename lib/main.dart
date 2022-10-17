import 'package:flutter/material.dart';
import 'package:places/UI/screens/add_sight_screen.dart';
import 'package:places/UI/screens/sight_type_selection_screen.dart';
import 'package:places/UI/screens/sight_search_screen.dart';
import 'package:places/mocks.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:places/ui/screens/sight_filters_screen.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/components/sight_card.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_sights_screen.dart';
import 'package:provider/provider.dart';

/// Признак использования тёмной темы в приложении.
bool isDarkModeEnabled = false;

/// Для оповещения приложения, что нужно обновить экран.
final ChangeNotifier changeNotifier = ChangeNotifier();

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => VisitingProvider(),
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    changeNotifier.addListener(() {
      setState(() {});
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkModeEnabled ? darkTheme : lightTheme,
      home: const VisitingSightsScreen(),
    );
  }
}
