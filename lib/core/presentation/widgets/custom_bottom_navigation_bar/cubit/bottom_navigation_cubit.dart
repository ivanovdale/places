import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(
          BottomNavigationState(selectedTabIndex: 0),
        );

  void onItemTapped(
    int index,
  ) {
    emit(
      state.copyWith(selectedTabIndex: index),
    );
  }
}
