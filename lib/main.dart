import 'package:flutter/material.dart';
import 'package:places/UI/screens/add_sight_screen.dart';
import 'package:places/UI/screens/sight_category_selection_screen.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/sight_card.dart';
import 'package:places/ui/screens/sight_details.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

/// Признак использования тёмной темы в приложении.
bool isDarkModeEnabled = true;

/// Для оповещения приложения, что нужно обновить экран.
final ChangeNotifier changeNotifier = ChangeNotifier();

void main() {
  runApp(const App());
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
      theme: isDarkModeEnabled ? darkTheme : lightTheme,
      home: const SightListScreen(),
    );
  }
}

