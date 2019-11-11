import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/presentation/utils/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', () {
    test(
      'should reture an integer when the string represents an unsigned integer',
      () async {
        // arrange
        final tString = '123';

        // act
        final result = inputConverter.stringToUnsignedInteger(tString);

        // assert
        final expectedInteger = 123;
        expect(result, equals(Right(expectedInteger)));
      },
    );

    test(
      'should reture an InvalidInputFailure when the string does not represent an integer',
      () async {
        // arrange
        final tString = '123.0';

        // act
        final result = inputConverter.stringToUnsignedInteger(tString);

        // assert
        expect(result, equals(Left(InvalidInputFailure())));
      },
    );

    test(
      'should reture an InvalidInputFailure when the string represent an negative integer',
      () async {
        // arrange
        final tString = '-123';

        // act
        final result = inputConverter.stringToUnsignedInteger(tString);

        // assert
        expect(result, equals(Left(InvalidInputFailure())));
      },
    );
  });
}
