import 'dart:async';

import 'package:places/core/domain/repository/first_enter_repository.dart';

final class FirstEnterInteractor {
  final FirstEnterRepository _firstEnterRepository;

  FutureOr<bool> get isFirstEnter => _firstEnterRepository.isFirstEnter;

  FirstEnterInteractor({
    required FirstEnterRepository firstEnterRepository,
  }) : _firstEnterRepository = firstEnterRepository;

  FutureOr<bool> saveFirstEnter() => _firstEnterRepository.saveFirstEnter();
}
