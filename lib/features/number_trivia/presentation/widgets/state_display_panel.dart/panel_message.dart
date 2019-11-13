import 'package:flutter/material.dart';

class PanelMessage extends StatelessWidget {
  const PanelMessage({
    Key key,
    @required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}