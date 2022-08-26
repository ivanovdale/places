import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: const _CustomAppBar(),
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

/// AppBar с кастомной высотой.
class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(152.0);

  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 64,
        bottom: 16,
      ),
      child: const Text(
        AppStrings.sightListAppBarTitle,
        style: AppTypography.roboto32Regular,
      ),
    );
  }
}
