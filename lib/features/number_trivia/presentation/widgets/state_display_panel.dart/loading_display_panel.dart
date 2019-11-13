import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDisplayPanel extends StatelessWidget {
  const LoadingDisplayPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: Colors.white,
      size: 50.0,
    );
  }
}
