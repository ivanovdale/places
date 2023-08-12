import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/features/on_boarding/utils/on_boarding_animation_helper.dart';

/// Приветственная картинка страницы онбординга.
class OnBoardingPageItemIcon extends StatefulWidget {
  final String assetName;
  final Color color;
  final PageController pageController;

  const OnBoardingPageItemIcon({
    super.key,
    required this.assetName,
    required this.color,
    required this.pageController,
  });

  @override
  State<OnBoardingPageItemIcon> createState() => _OnBoardingPageItemIconState();
}

class _OnBoardingPageItemIconState extends State<OnBoardingPageItemIcon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _sizeAnimation;
  late final Animation<double> _opacityAnimation;

  void _startAnimation() => _animationController
    ..reset()
    ..forward();

  @override
  void initState() {
    super.initState();
    final (:controller, :sizeAnimation, :opacityAnimation) =
        OnBoardingAnimationHelper.getSettings(vsync: this);
    _animationController = controller..forward();
    _sizeAnimation = sizeAnimation;
    _opacityAnimation = opacityAnimation;
    widget.pageController.addListener(_startAnimation);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_startAnimation);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 42),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Opacity(
          opacity: _opacityAnimation.value,
          child: SvgPicture.asset(
            widget.assetName,
            width: _sizeAnimation.value,
            colorFilter: ColorFilter.mode(
              widget.color,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
