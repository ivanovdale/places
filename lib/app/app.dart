import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/UI/screens/res/themes.dart';
import 'package:places/app/app_providers.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            initialRoute: AppRouter.root,
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: context.watch<SettingsCubit>().state.isDarkModeEnabled
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
