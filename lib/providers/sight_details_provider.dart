import 'package:flutter/material.dart';

/// Вьюмодель для экрана детализации достопримечательности.
class SightDetailsProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int activePage = 0;

  /// Устанавливает активную страницу.
  void setActivePage(int page) {
    activePage = page;
    notifyListeners();
  }
}
