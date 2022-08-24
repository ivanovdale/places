import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';

class SightDetailsTop extends StatelessWidget {
  const SightDetailsTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.lightBlueShade800,
        ),
        Positioned(
          left: 16,
          top: 36,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            width: 32,
            height: 32,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15.0,
              color: AppColors.martinique,
            ),
          ),
        ),
      ],
    );
  }
}
