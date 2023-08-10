import 'package:flutter/material.dart';

typedef AnimationSettings = ({
  AnimationController controller,
  Animation<double> animation,
});

abstract final class LogoAnimationHelper {
  static AnimationSettings getSettings({
    required TickerProvider vsync,
  }) {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: vsync,
    )..repeat();
    final rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    return (
      controller: animationController,
      animation: rotationAnimation,
    );
  }
}
