import 'package:flutter/material.dart';

import '../widgets/trivia_display_panel.dart';
import '../widgets/trivia_search_panel.dart';

class NumberTriviaScreen extends StatelessWidget {
  const NumberTriviaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: TriviaDisplayPanel(),
            ),
            TriviaSearchPanel(),
            // Expanded(flex: 4, child: Container()),
          ],
        ),
      ),
    );
  }
}
