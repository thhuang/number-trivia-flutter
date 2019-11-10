import 'http_response.dart';

abstract class HttpClient {
  Future<HttpResponse> get(String url, {Map<String, String> headers});
}

// class HttpClientImpl implements HttpClient {
//   @override
//   Future<HttpResponse> get(String url, {Map<String, String> headers}) {
//     return get(url, headers: headers);
//   }
// }
