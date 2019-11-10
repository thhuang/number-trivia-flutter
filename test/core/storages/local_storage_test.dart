import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/storages/local_storage.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  LocalStorageImpl localStorage;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localStorage = LocalStorageImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getString', () {
    test(
      'should forward the call to SharedPreferences.getString',
      () async {
        // arrange
        final tReturnString =
            jsonEncode(NumberTriviaModel(number: 1, text: 'test'));
        when(mockSharedPreferences.getString(any)).thenReturn(tReturnString);

        // act
        final result = await localStorage.getString(CACHED_NUMBER_TRIVIA);

        // assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, tReturnString);
      },
    );
  });
}
