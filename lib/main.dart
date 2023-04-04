import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:places/API/dio_api.dart';
import 'package:places/app/app.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/providers/bottom_bar_provider.dart';
import 'package:places/providers/place_interactor_provider.dart';
import 'package:places/providers/settings_interactor_provider.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final networkPlaceRepository = NetworkPlaceRepository(DioApi());
  GetIt.instance.registerSingleton<PlaceRepository>(networkPlaceRepository);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlaceInteractorProvider(networkPlaceRepository),
        ),
        ChangeNotifierProvider(create: (context) => BottomBarProvider()),
        ChangeNotifierProvider(
          create: (context) => SettingsInteractorProvider(SettingsInteractor()),
        ),
        ChangeNotifierProxyProvider<PlaceInteractorProvider, VisitingProvider>(
          update: (context, interactor, previousMessages) =>
              VisitingProvider(interactor),
          create: (context) => VisitingProvider(null),
        ),
      ],
      child: const App(),
    ),
  );
}
