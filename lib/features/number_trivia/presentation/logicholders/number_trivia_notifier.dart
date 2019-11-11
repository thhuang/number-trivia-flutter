import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../../../core/presentation/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

class NumberTriviaNotifier with ChangeNotifier {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTrivia numberTrivia;
  NumberTriviaState state = NumberTriviaState.empty;

  NumberTriviaNotifier({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;
}

enum NumberTriviaState {
  empty,
  loading,
  loaded,
  error,
}
