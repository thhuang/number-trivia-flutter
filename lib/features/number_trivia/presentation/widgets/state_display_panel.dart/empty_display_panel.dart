import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/state_display_panel.dart/panel_message.dart';

class EmptyDisplayPanel extends StatelessWidget {
  const EmptyDisplayPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PanelMessage(
      message:
          'Get the trivia of your lucky number or enter a number to search!',
    );
  }
}
