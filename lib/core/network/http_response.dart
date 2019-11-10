import 'package:http/http.dart';
import 'package:meta/meta.dart';

abstract class HttpResponse {
  HttpResponse({@required body, @required statusCode});
  String get body;
  int get statusCode;
}
