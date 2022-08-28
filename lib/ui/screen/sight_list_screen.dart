import 'package:flutter/material.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/components/custom_app_bar.dart';
import 'package:places/ui/screen/components/custom_bottom_navigation_bar.dart';
import 'package:places/ui/screen/sight_card.dart';

/// Список достопримечательностей.
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.sightListAppBarTitle,
        titleTextStyle: AppTypography.roboto32Regular,
        toolbarHeight: 141,
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 64,
          bottom: 21,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
          ),
          child: Column(
            children: mocks.map(SightCard.new).toList(),
          ),
        ),
      ),
    );
  }
}
