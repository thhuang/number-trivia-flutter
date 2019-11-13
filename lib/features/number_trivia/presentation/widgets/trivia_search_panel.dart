import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logicholders/number_trivia_notifier.dart';
import 'custom_button.dart';
import 'number_input_field.dart';
import 'search_button.dart';

class TriviaSearchPanel extends StatelessWidget {
  const TriviaSearchPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<String>>(
      builder: (_) => ValueNotifier<String>(''),
      child: Column(
        children: <Widget>[
          NumberInputField(),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SearchButton(),
              CustomButton(
                text: 'Lucky',
                onPressed: () {
                  Provider.of<NumberTriviaNotifier>(context)
                      .getRandomNumberTrivia();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
