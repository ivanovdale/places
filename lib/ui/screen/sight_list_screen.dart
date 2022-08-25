import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/mocks.dart';
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
    final sightCardList = mocks.map(SightCard.new).toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 136,
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          AppStrings.sightListAppBarTitle,
          style: AppTypography.roboto32Regular,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
          ),
          child: Column(
            children: sightCardList,
          ),
        ),
      ),
    );
  }
}
