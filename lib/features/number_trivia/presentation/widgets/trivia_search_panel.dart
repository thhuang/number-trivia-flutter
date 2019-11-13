import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logicholders/number_trivia_notifier.dart';
import 'buttons/custom_button.dart';
import 'buttons/search_button.dart';
import 'input_fields.dart/number_input_field.dart';

class TriviaSearchPanel extends StatelessWidget {
  const TriviaSearchPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<TextEditingController>>(
      builder: (_) => ValueNotifier<TextEditingController>(TextEditingController()),
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
