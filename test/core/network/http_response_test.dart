import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia/core/network/http_response.dart';

import '../../fixtures/fixture_reader.dart';

class MockResponse extends Mock implements http.Response {}

void main() {
  HttpResponseImpl httpResponse;
  MockResponse mockResponse;

  setUp(() {
    mockResponse = MockResponse();
    httpResponse = HttpResponseImpl(response: mockResponse);
  });

  group('body', () {
    test('should forward the call to http.Response.body', () async {
      // arrange
      final String tResponseBody = fixture('trivia.json');
      when(mockResponse.body).thenReturn(tResponseBody);

      // act
      final result = httpResponse.body;

      // assert
      verify(mockResponse.body);
      expect(result, tResponseBody);
    });
  });

  group('statusCode', () {
    test('should forward the call to http.Response.statusCode', () async {
      // arrange
      final int tResponseStatusCode = 200;
      when(mockResponse.statusCode).thenReturn(tResponseStatusCode);

      // act
      final result = httpResponse.statusCode;

      // assert
      verify(mockResponse.statusCode);
      expect(result, tResponseStatusCode);
    });
  });
}
