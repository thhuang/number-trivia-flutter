import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NumberTrivia extends Equatable {
  final String text;
  final double number;

  NumberTrivia({
    @required this.text,
    @required this.number,
  });

  @override
  List<Object> get props => [text, number];
}
