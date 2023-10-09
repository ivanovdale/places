import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/map/presentation/map_launcher_cubit/map_launcher_cubit.dart';
import 'package:places/features/map/presentation/widgets/map_app_picker.dart';

Future<void> mapLauncherListener(
  BuildContext context,
  MapLauncherState state,
  Place? place,
) async {
  if (state is MapLauncherShowInstalledMapsPicker && place != null) {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => MapAppPicker(
        place: place,
        maps: state.installedMaps,
        onMapPressed: (action) =>
            context.read<MapLauncherCubit>().showDirections(
                  mapType: action.type,
                  place: place,
                ),
      ),
    );
  }
}
