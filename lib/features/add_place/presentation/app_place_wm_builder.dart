import 'package:flutter/material.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/features/add_place/presentation/add_place_model.dart';
import 'package:places/features/add_place/presentation/add_place_wm.dart';
import 'package:provider/provider.dart';

AddPlaceWM createAddPlaceWM(BuildContext context) => AddPlaceWM(
      AddPlaceModel(
        placeInteractor: context.read<PlaceInteractor>(),
      ),
    );
