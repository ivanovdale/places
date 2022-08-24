import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/ui/screen/sight_details/build_route_button.dart';
import 'package:places/ui/screen/sight_details/padded_divider.dart';
import 'package:places/ui/screen/sight_details/sight_actions_buttons.dart';
import 'package:places/ui/screen/sight_details/sight_info.dart';

class SightDetailsBottom extends StatelessWidget {
  final Sight sight;

  const SightDetailsBottom({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          SightInfo(sight: sight),
          const BuildRouteButton(),
          const PaddedDivider(
            top: 24,
            left: 16,
            right: 16,
            bottom: 19,
            thickness: 0.8,
          ),
          const SightActionsButtons(),
        ],
      ),
    );
  }
}
