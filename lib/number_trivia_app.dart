import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:number_trivia/features/number_trivia/presentation/screens/number_trivia_screen.dart';
import 'package:provider/provider.dart';

import 'provider_setup.dart';

class NumberTriviaApp extends StatelessWidget {
  const NumberTriviaApp({Key key}) : super(key: key);
  final int primaryColorCode = 0xFF58B2DC;
  final int scaffoldBackgroundColor = 0xFF1D2137;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Number Trivia App',
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(primaryColorCode),
          scaffoldBackgroundColor: Color(scaffoldBackgroundColor),
          accentColor: Colors.black87,
          // canvasColor: Colors.transparent,
        ),
        home: NumberTriviaScreen(),
      ),
    );
  }
}
