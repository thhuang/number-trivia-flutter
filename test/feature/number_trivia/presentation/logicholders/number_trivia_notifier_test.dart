import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/presentation/utils/input_converter.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/logicholders/number_trivia_notifier.dart';
import 'package:number_trivia/features/number_trivia/presentation/logicholders/number_trivia_states.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaNotifier numberTriviaNotifier;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;
  List<NumberTriviaState> stateLog;
  VoidCallback stateListener;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaNotifier = NumberTriviaNotifier(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
    stateLog = <NumberTriviaState>[];
    stateListener = () => stateLog.add(numberTriviaNotifier.state);
    numberTriviaNotifier.addListener(stateListener);
  });

  tearDown(() {
    numberTriviaNotifier.removeListener(stateListener);
    stateLog.clear();
  });

  group('constructor', () {
    test(
      'should initialize the state with NumberTriviaState.empty',
      () async {
        // assert
        final tExpectedState = Empty();
        expect(numberTriviaNotifier.state, tExpectedState);
      },
    );
  });

  group('getConcreteNumberTrivia', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    void setUpMockInputConverterFailure() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));

    void setUpMockConcreteNumberTriviaSuccess() =>
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

    test(
      '''should call InputConverter.stringToUnsignedInteger to validate
       and convert the string to an unsigned integer''',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockConcreteNumberTriviaSuccess();

        // act
        numberTriviaNotifier.getConcreteNumberTrivia(tNumberString);
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should update the state to Loading when the getConcreteNumberTrivia is called',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockConcreteNumberTriviaSuccess();

        // act
        numberTriviaNotifier.getConcreteNumberTrivia(tNumberString);

        // assert
        final tExpectedStateLog = [Loading()];
        expect(stateLog, tExpectedStateLog);
      },
    );

    test(
      'should update the state to Error when the input is invalid',
      () async {
        // arrange
        setUpMockInputConverterFailure();

        // act
        numberTriviaNotifier.getConcreteNumberTrivia(tNumberString);
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

        // assert
        final tExpectedStateLog = [
          Loading(),
          Error(message: kInvalidInputFailureMessage),
        ];
        expect(stateLog, tExpectedStateLog);
      },
    );

    test(
      'should get NumberTrivia from GetConcreteNumberTrivia use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockConcreteNumberTriviaSuccess();

        // act
        numberTriviaNotifier.getConcreteNumberTrivia(tNumberString);
        await untilCalled(mockGetConcreteNumberTrivia);

        // assert
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      },
    );

    test(
      'should update state to Loaded and update numberTrivia when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockConcreteNumberTriviaSuccess();

        // act
        await numberTriviaNotifier.getConcreteNumberTrivia(tNumberString);

        // exptected
        final tExpectedStateLog = [
          Loading(),
          Loaded(),
        ];
        expect(stateLog, tExpectedStateLog);
        expect(numberTriviaNotifier.numberTrivia, tNumberTrivia);
      },
    );

    test(
      'should update state to Error when getting data failed',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // act
        await numberTriviaNotifier.getConcreteNumberTrivia(tNumberString);

        // exptected
        final tExpectedStateLog = [
          Loading(),
          Error(message: kServerFailureMessage),
        ];
        expect(stateLog, tExpectedStateLog);
      },
    );

    test(
      'should update state to Error with a proper message when getting data failed',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));

        // act
        await numberTriviaNotifier.getConcreteNumberTrivia(tNumberString);

        // exptected
        final tExpectedStateLog = [
          Loading(),
          Error(message: kCacheFailureMessage),
        ];
        expect(stateLog, tExpectedStateLog);
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

    void setUpMockRandomNumberTriviaSuccess() =>
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

    test(
      'should update the state to Loading when the getRandomNumberTrivia is called',
      () async {
        // arrange
        setUpMockRandomNumberTriviaSuccess();

        // act
        numberTriviaNotifier.getRandomNumberTrivia();

        // assert
        final tExpectedStateLog = [Loading()];
        expect(stateLog, tExpectedStateLog);
      },
    );

    test(
      'should get NumberTrivia from GetRandomNumberTrivia use case',
      () async {
        // arrange
        setUpMockRandomNumberTriviaSuccess();

        // act
        numberTriviaNotifier.getRandomNumberTrivia();
        await untilCalled(mockGetRandomNumberTrivia(any));

        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should update state to Loaded and update numberTrivia when data is gotten successfully',
      () async {
        // arrange
        setUpMockRandomNumberTriviaSuccess();

        // act
        await numberTriviaNotifier.getRandomNumberTrivia();

        // exptected
        final tExpectedStateLog = [
          Loading(),
          Loaded(),
        ];
        expect(stateLog, tExpectedStateLog);
        expect(numberTriviaNotifier.numberTrivia, tNumberTrivia);
      },
    );

    test(
      'should update state to Error when getting data failed',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // act
        await numberTriviaNotifier.getRandomNumberTrivia();

        // exptected
        final tExpectedStateLog = [
          Loading(),
          Error(message: kServerFailureMessage),
        ];
        expect(stateLog, tExpectedStateLog);
      },
    );

    test(
      'should update state to Error with a proper message when getting data failed',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));

        // act
        await numberTriviaNotifier.getRandomNumberTrivia();

        // exptected
        final tExpectedStateLog = [
          Loading(),
          Error(message: kCacheFailureMessage),
        ];
        expect(stateLog, tExpectedStateLog);
      },
    );
  });
}
