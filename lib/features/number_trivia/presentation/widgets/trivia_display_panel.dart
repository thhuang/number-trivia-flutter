import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/logicholders/number_trivia_states.dart';
import 'package:provider/provider.dart';

import '../logicholders/number_trivia_notifier.dart';

class TriviaDisplayPanel extends StatelessWidget {
  const TriviaDisplayPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberTriviaState = Provider.of<NumberTriviaNotifier>(context).state;
    final triviaNumber = numberTriviaState == Loaded()
        ? Provider.of<NumberTriviaNotifier>(context)
            .numberTrivia
            .number
            .toStringAsFixed(0)
        : '';
    final triviaText = numberTriviaState == Loaded()
        ? Provider.of<NumberTriviaNotifier>(context).numberTrivia.text
        : '';

    return Column(
      children: <Widget>[
        SizedBox(height: 30.0),
        Text(
          triviaNumber,
          style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                triviaText,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
