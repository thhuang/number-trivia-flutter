import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

import '../../../../core/presentation/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';
import 'number_trivia_states.dart';

class NumberTriviaNotifier with ChangeNotifier {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;

  NumberTrivia numberTrivia;
  NumberTriviaState state = Empty();

  NumberTriviaNotifier({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required InputConverter inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        _getConcreteNumberTrivia = concrete,
        _getRandomNumberTrivia = random,
        _inputConverter = inputConverter;

  Future<void> getConcreteNumberTrivia(String numberString) async {
    _loadingStateTransition();

    final inputEither = _inputConverter.stringToUnsignedInteger(numberString);
    inputEither.fold(
      (failure) {
        _errorStateTransition(kInvalidInputFailureMessage);
      },
      (numberParsed) async {
        final eitherFailureOrTrivia =
            await _getConcreteNumberTrivia(Params(number: numberParsed));
        _eitherLoadedOrErrorTransition(eitherFailureOrTrivia);
      },
    );
  }

  Future<void> getRandomNumberTrivia() async {
    _loadingStateTransition();

    final eitherFailureOrTrivia = await _getRandomNumberTrivia(NoParams());
    _eitherLoadedOrErrorTransition(eitherFailureOrTrivia);
  }

  void _eitherLoadedOrErrorTransition(
      Either<Failure, NumberTrivia> eitherFailureOrTrivia) {
    eitherFailureOrTrivia.fold(
      (failure) => _errorStateTransition(_mapFailureToMessage(failure)),
      (trivia) {
        numberTrivia = trivia;
        _loadedStateTransition();
      },
    );
  }

  void _loadingStateTransition() {
    state = Loading();
    notifyListeners();
  }

  void _errorStateTransition(String message) {
    state = Error(message: message);
    notifyListeners();
  }

  void _loadedStateTransition() {
    state = Loaded();
    notifyListeners();
  }
}

const String kServerFailureMessage = 'Server Failure';
const String kCacheFailureMessage = 'Cache Failure';
const String kInvalidInputFailureMessage =
    'Invalid Input: The number must be a positive integer or zero';

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return kServerFailureMessage;
    case CacheFailure:
      return kCacheFailureMessage;
    default:
      return 'Unexpected error';
  }
}
