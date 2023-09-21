import 'package:flutter/cupertino.dart';

extension ScreenUtil on BuildContext {
  static const _smallScreenWidth = 375;

  bool get isSmallScreenWidth =>
      MediaQuery.sizeOf(this).width <= _smallScreenWidth;
}
