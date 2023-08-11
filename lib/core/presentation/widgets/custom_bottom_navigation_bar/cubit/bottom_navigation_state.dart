part of 'bottom_navigation_cubit.dart';

final class BottomNavigationState {
  final int selectedTabIndex;

  BottomNavigationState({
    required this.selectedTabIndex,
  });

  BottomNavigationState copyWith({
    int? selectedTabIndex,
  }) {
    return BottomNavigationState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}
