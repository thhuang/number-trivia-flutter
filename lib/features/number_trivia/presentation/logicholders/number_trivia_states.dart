import 'package:equatable/equatable.dart';

abstract class NumberTriviaState extends Equatable {
  @override
  List<Object> get props => null;
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {}

class Error extends NumberTriviaState {
  final message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}