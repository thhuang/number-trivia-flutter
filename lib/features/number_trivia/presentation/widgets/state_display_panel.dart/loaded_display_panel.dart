import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logicholders/number_trivia_notifier.dart';

class LoadedDisplayPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: AutoSizeText(
            Provider.of<NumberTriviaNotifier>(context)
                .numberTrivia
                .number
                .toStringAsFixed(0),
            maxLines: 1,
            style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                Provider.of<NumberTriviaNotifier>(context).numberTrivia.text,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
