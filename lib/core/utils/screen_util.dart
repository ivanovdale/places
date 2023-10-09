import 'package:flutter/cupertino.dart';

extension ScreenUtil on BuildContext {
  static const _smallScreenWidth = 340;
  static const _smallScreenHeight = 685;

  bool get _isSmallScreenWidth =>
      MediaQuery.sizeOf(this).width <= _smallScreenWidth;

  bool get _isSmallScreenHeight =>
      MediaQuery.sizeOf(this).height <= _smallScreenHeight;

  bool get isSmallScreen => _isSmallScreenWidth || _isSmallScreenHeight;
}
