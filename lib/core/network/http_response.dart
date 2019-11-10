import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class HttpResponse {
  String get body;
  int get statusCode;
}

class HttpResponseImpl extends Equatable implements HttpResponse {
  final http.Response response;

  HttpResponseImpl({@required this.response});

  @override
  String get body => response.body;

  @override
  int get statusCode => response.statusCode;

  @override
  List<Object> get props => [response];

}
