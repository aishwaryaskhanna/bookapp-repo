import 'dart:io';
import 'package:flutter/material.dart';

class ExitPopup {
  showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Are you sure?',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        content: Text('Press OK to exit the app.'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
