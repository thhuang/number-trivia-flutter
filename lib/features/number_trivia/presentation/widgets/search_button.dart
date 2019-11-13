import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logicholders/number_trivia_notifier.dart';
import 'custom_button.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Search',
      onPressed: () {
        final numberString = Provider.of<ValueNotifier<String>>(context).value;
        Provider.of<NumberTriviaNotifier>(context)
            .getConcreteNumberTrivia(numberString);
      },
    );
  }
}
