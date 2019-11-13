import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logicholders/number_trivia_notifier.dart';
import '../../logicholders/number_trivia_states.dart';
import 'panel_message.dart';

class ErrorDisplayPanel extends StatelessWidget {
  const ErrorDisplayPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Error errorState = Provider.of<NumberTriviaNotifier>(context).state;
    return PanelMessage(message: errorState.message);
  }
}


