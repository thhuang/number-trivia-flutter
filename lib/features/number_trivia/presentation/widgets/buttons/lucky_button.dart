import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logicholders/number_trivia_notifier.dart';
import 'custom_button.dart';

class LuckyButton extends StatelessWidget {
  const LuckyButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Lucky',
      onPressed: () {
        Provider.of<NumberTriviaNotifier>(context)
            .getRandomNumberTrivia();
        FocusScope.of(context).unfocus();
      },
    );
  }
}