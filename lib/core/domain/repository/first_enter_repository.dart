import 'dart:async';

abstract interface class FirstEnterRepository {
  FutureOr<bool> saveFirstEnter();

  FutureOr<bool> get isFirstEnter;
}
