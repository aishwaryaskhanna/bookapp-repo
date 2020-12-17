import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SpinKitFadingCircle(
      color: Colors.cyanAccent,
    );
  }
}
