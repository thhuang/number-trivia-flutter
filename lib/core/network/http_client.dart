import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'http_response.dart';

abstract class HttpClient {
  Future<HttpResponse> get(String url, {Map<String, String> headers});
}

class HttpClientImpl implements HttpClient {
  final http.Client client;

  HttpClientImpl({@required this.client});

  @override
  Future<HttpResponse> get(String url, {Map<String, String> headers}) async {
    final response = await client.get(url, headers: headers);
    return HttpResponseImpl(response: response);
  }
}
