import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  final AnimationController animationController;
  final Widget previousChild;
  final Widget currentChild;
  final double startOpacity;
  final double endOpacity;

  late final Animation<double> _previousChildAnimation = Tween<double>(
    begin: startOpacity,
    end: endOpacity,
  ).animate(
    animationController,
  );
  late final Animation<double> _currentChildAnimation = Tween<double>(
    begin: endOpacity,
    end: startOpacity,
  ).animate(
    animationController,
  );

  CustomAnimatedSwitcher({
    super.key,
    required this.animationController,
    required this.previousChild,
    required this.currentChild,
    required this.startOpacity,
    required this.endOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeTransition(
          opacity: _previousChildAnimation,
          child: previousChild,
        ),
        FadeTransition(
          opacity: _currentChildAnimation,
          child: currentChild,
        ),
      ],
    );
  }
}
