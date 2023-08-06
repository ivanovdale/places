part of 'on_boarding_cubit.dart';

final class OnBoardingState {
  final int activePage;

  const OnBoardingState({
    required this.activePage,
  });

  OnBoardingState copyWith({
    int? activePage,
  }) {
    return OnBoardingState(
      activePage: activePage ?? this.activePage,
    );
  }
}
