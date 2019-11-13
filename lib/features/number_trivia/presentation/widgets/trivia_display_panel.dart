import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logicholders/number_trivia_notifier.dart';
import '../logicholders/number_trivia_states.dart';
import 'state_display_panel.dart/loaded_display_panel.dart';

class TriviaDisplayPanel extends StatelessWidget {
  const TriviaDisplayPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberTriviaState = Provider.of<NumberTriviaNotifier>(context).state;
    return widgetSwitch(numberTriviaState);
  }

  Widget widgetSwitch(NumberTriviaState numberTriviaState) {
    // TODO: handle other states
    if (numberTriviaState == Loaded()) {
      return LoadedDisplayPanel();
    } else {
      return Container();
    }
  }
}
