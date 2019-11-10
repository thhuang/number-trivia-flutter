import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/http_client.dart';
import 'package:number_trivia/core/network/http_response.dart';

import '../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  HttpClientImpl httpClient;
  MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    httpClient = HttpClientImpl(client: mockClient);
  });

  group('get', () {
    test('should forward the call to http.Client.get', () async {
      // arrange
      final tResponse = http.Response(fixture('trivia.json'), 200);
      final tHttpResponse = HttpResponseImpl(response: tResponse);
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => tResponse);

      // act
      final result = await httpClient.get(
        'http://numbersapi.com/random',
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // assert
      verify(
        mockClient.get(
          'http://numbersapi.com/random',
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      expect(result, tHttpResponse);
    });
  });
}
