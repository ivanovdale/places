import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';

/// Кастомный BottomNavigationBar.
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.waterlooInactive, width: 3),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 3,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: AppColors.oxfordBlue,
        unselectedItemColor: AppColors.oxfordBlue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }
}
