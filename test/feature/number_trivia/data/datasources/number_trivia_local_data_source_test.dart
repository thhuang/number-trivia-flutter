import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/storages/local_storage.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    dataSource =
        NumberTriviaLocalDataSourceImpl(localStorage: mockLocalStorage);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      jsonDecode(
        fixture('trivia_cached.json'),
      ),
    );

    test(
      'should return NumberTriviaModel from LocalStorage when there is one in the cached',
      () async {
        // arrange
        when(mockLocalStorage.getString(any))
            .thenAnswer((_) async => fixture('trivia_cached.json'));

        // act
        final result = await dataSource.getLastNumberTrivia();

        // assert
        verify(mockLocalStorage.getString(CACHED_NUMBER_TRIVIA));
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should throw a CacheException when there is not a cached value',
      () async {
        // arrange
        when(mockLocalStorage.getString(any)).thenAnswer((_) async => null);

        // assert
        try {
          await dataSource.getLastNumberTrivia();
        } catch (e) {
          expect(e, isInstanceOf<CacheException>());
        }
      },
    );
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');

    test(
      'should call LocalStorage to cache the data',
      () async {
        // act
        await dataSource.cacheNumberTrivia(tNumberTriviaModel);

        // assert
        final expectedJsonString = jsonEncode(tNumberTriviaModel);
        verify(mockLocalStorage.setString(
          CACHED_NUMBER_TRIVIA,
          expectedJsonString,
        ));
      },
    );
  });
}
