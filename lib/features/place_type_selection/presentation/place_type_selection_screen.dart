import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_app_bar.dart';
import 'package:places/core/utils/string_extension.dart';
import 'package:places/features/place_type_selection/presentation/cubit/place_type_selection_cubit.dart';
import 'package:places/features/place_type_selection/presentation/widgets/place_types_list.dart';

/// Экран выбора категории места.
class PlaceTypeSelectionScreen extends StatelessWidget {
  final PlaceTypes? placeType;

  const PlaceTypeSelectionScreen({
    Key? key,
    this.placeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: AppStrings.placeType.capitalize(),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        toolbarHeight: 56,
        leading: const BackButton(),
      ),
      body: BlocProvider(
        create: (context) => PlaceTypeSelectionCubit(placeType),
        child: const PlaceTypesList(),
      ),
    );
  }
}
