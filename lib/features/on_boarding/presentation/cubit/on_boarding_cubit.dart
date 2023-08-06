import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit()
      : super(
          const OnBoardingState(activePage: 0),
        );

  void setActivePage(int page) {
    emit(
      state.copyWith(activePage: page),
    );
  }
}
