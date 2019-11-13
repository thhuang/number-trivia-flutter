import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logicholders/number_trivia_notifier.dart';
import 'custom_button.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ValueNotifier<TextEditingController>,
        NumberTriviaNotifier>(
      builder: (_, controller, numberTrivia, __) => CustomButton(
        text: 'Search',
        onPressed: () {
          final numberString = controller.value.text;
          numberTrivia.getConcreteNumberTrivia(numberString);
          controller.value.clear();
        },
      ),
    );
  }
}
