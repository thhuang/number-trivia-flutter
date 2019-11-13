import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const CustomButton({
    Key key,
    this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        height: 40.0,
        width: 70.0,
      ),
      onPressed: onPressed,
    );
  }
}
