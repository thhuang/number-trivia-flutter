import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/network/http_client.dart';
import 'package:number_trivia/core/network/http_response.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpResponse extends Mock implements HttpResponse {}

void main() {
  NumberTriviaRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;
  MockHttpResponse mockHttpResponse;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
    mockHttpResponse = MockHttpResponse();
  });

  final tJsonString = fixture('trivia.json');
  final tNumberTriviaModel = NumberTriviaModel.fromJson(
    jsonDecode(
      tJsonString,
    ),
  );

  void runTestHttpClientSuccess(Function body) {
    group('status code is 200 (success)', () {
      setUp(() {
        when(mockHttpResponse.body).thenReturn(tJsonString);
        when(mockHttpResponse.statusCode).thenReturn(200);
      });

      body();
    });
  }

  void runTestHttpClientFailure(Function body) {
    group('status code is not 200 (failure)', () {
      setUp(() {
        when(mockHttpResponse.body).thenReturn('Something wet wrong');
        when(mockHttpResponse.statusCode).thenReturn(404);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;

    setUp(() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => mockHttpResponse,
      );
    });

    runTestHttpClientSuccess(() {
      test(
        '''should perform a GET request on a URL with a number
         being the endpoint and with application/json header''',
        () async {
          // act
          dataSource.getConcreteNumberTrivia(tNumber);

          // assert
          verify(mockHttpClient.get(
            'http://numbersapi.com/$tNumber',
            headers: {
              'Content-Type': 'application/json',
            },
          ));
        },
      );

      test(
        'should return NumberTriviaModel',
        () async {
          // act
          final result = await dataSource.getConcreteNumberTrivia(tNumber);

          // assert
          expect(result, tNumberTriviaModel);
        },
      );
    });

    runTestHttpClientFailure(() {
      test(
        'should throw a ServerException',
        () async {
          // act
          final call = dataSource.getConcreteNumberTrivia;

          // assert
          expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
        },
      );
    });
  });

  group('getRandomNumberTrivia', () {
    setUp(() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => mockHttpResponse,
      );
    });

    runTestHttpClientSuccess(() {
      test(
        '''should perform a GET request on a URL with a number
         being the endpoint and with application/json header''',
        () async {
          // act
          dataSource.getRandomNumberTrivia();

          // assert
          verify(mockHttpClient.get(
            'http://numbersapi.com/random',
            headers: {
              'Content-Type': 'application/json',
            },
          ));
        },
      );

      test(
        'should return NumberTriviaModel',
        () async {
          // act
          final result = await dataSource.getRandomNumberTrivia();

          // assert
          expect(result, tNumberTriviaModel);
        },
      );
    });

    runTestHttpClientFailure(() {
      test(
        'should throw a ServerException',
        () async {
          // act
          final call = dataSource.getRandomNumberTrivia;

          // assert
          expect(() => call(), throwsA(TypeMatcher<ServerException>()));
        },
      );
    });
  });
}
