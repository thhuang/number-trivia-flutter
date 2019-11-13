import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/state_display_panel.dart/empty_display_panel.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/state_display_panel.dart/error_display_panel.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/state_display_panel.dart/loading_display_panel.dart';
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
    final stateType = numberTriviaState.runtimeType;
    if (stateType == Loaded) {
      return LoadedDisplayPanel();
    } else if (stateType == Loading) {
      return LoadingDisplayPanel();
    } else if (stateType == Empty) {
      return EmptyDisplayPanel();
    } else if (stateType == Error) {
      return ErrorDisplayPanel();
    } else {
      return Center(child: Text('Unexpected Error'));
    }
  }
}
