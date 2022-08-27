import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/ui/screen/components/custom_app_bar.dart';

class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.visitingScreenAppBarTitle,
          titleTextStyle: AppTypography.roboto18RegularSubtitle.copyWith(
            color: AppColors.martinique,
          ),
          centerTitle: true,
          toolbarHeight: 56.0,
          padding: const EdgeInsets.only(
            top: 24.0,
            bottom: 6.0,
          ),
        ),
        body: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}
