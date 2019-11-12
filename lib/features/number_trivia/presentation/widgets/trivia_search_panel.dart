import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logicholders/number_trivia_notifier.dart';

class TriviaSearchPanel extends StatelessWidget {
  const TriviaSearchPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text('Search'),
          onPressed: () {
            Provider.of<NumberTriviaNotifier>(context).getRandomNumberTrivia();
          },
        ),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text('Random'),
          onPressed: () {
            Provider.of<NumberTriviaNotifier>(context).getRandomNumberTrivia();
          },
        ),
      ],
    );
  }
}
