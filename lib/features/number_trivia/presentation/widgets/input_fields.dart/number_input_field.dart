import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: clear the input field after tapping search
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
      style: TextStyle(fontSize: 20.0),
    );
  }
}
