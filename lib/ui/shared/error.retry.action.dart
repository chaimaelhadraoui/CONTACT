import 'package:flutter/material.dart';

class ErrorRetryMessage extends StatelessWidget {
  String errorMessage;
  Function onAction;

  ErrorRetryMessage({this.errorMessage, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${errorMessage}"),
        RaisedButton(
          onPressed: onAction,
          child: Text(
            'Retry',
            style: TextStyle(color: Colors.cyan),
          ),
          color: Color(0xff1b1b34),
        ),
      ],
    );
  }
}