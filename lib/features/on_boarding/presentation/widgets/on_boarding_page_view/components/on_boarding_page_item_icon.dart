import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:places/features/on_boarding/utils/on_boarding_animation_helper.dart';

/// Приветственная картинка страницы онбординга.
class OnBoardingPageItemIcon extends StatefulWidget {
  final String assetName;
  final Color color;

  const OnBoardingPageItemIcon({
    super.key,
    required this.assetName,
    required this.color,
  });

  @override
  State<OnBoardingPageItemIcon> createState() => _OnBoardingPageItemIconState();
}

class _OnBoardingPageItemIconState extends State<OnBoardingPageItemIcon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _sizeAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    final (:controller, :sizeAnimation, :opacityAnimation) =
        OnBoardingAnimationHelper.getSettings(vsync: this);
    _animationController = controller..forward();
    _sizeAnimation = sizeAnimation;
    _opacityAnimation = opacityAnimation;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) => _animationController.forward(),
      child: Padding(
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
      ),
    );
  }
}
