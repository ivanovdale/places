import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/providers/bottom_bar_provider.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

/// Признак использования тёмной темы в приложении.
bool isDarkModeEnabled = false;

/// Для оповещения приложения, что нужно обновить экран.
final ChangeNotifier changeNotifier = ChangeNotifier();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VisitingProvider()),
        ChangeNotifierProvider(create: (context) => BottomBarProvider()),
      ],
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
    // Локализация форматирования даты в приложении.
    initializeDateFormatting('ru', '');

    return MaterialApp(
      initialRoute: AppRouter.root,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: isDarkModeEnabled ? darkTheme : lightTheme,
    );
  }
}
