import 'package:flutter/material.dart';

typedef OnBoardingAnimationSettings = ({
  AnimationController controller,
  Animation<double> sizeAnimation,
  Animation<double> opacityAnimation,
});

abstract final class OnBoardingAnimationHelper {
  static OnBoardingAnimationSettings getSettings({
    required TickerProvider vsync,
  }) {
    final animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
    final sizeAnimation = Tween<double>(
      begin: 15,
      end: 104,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    final opacityAnimation = Tween<double>(
      begin: 0.1,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    return (
      controller: animationController,
      sizeAnimation: sizeAnimation,
      opacityAnimation: opacityAnimation,
    );
  }
}
