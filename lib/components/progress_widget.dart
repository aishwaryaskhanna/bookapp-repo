import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressWidget extends StatelessWidget {
  ProgressWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.cyanAccent,
      ),
    );
  }
}
