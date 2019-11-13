import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) =>
          Provider.of<ValueNotifier<String>>(context).value = value,
      keyboardAppearance: Brightness.dark,
      keyboardType: TextInputType.number,
      autofocus: true,
      textAlign: TextAlign.center,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        hintText: 'Enter a number!',
      ),
    );
  }
}
