import 'package:flutter/material.dart';
import 'package:book_app/components/progress_widget.dart';
import 'package:book_app/util/api_request_status.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus response;
  final Widget child;
  final Function reload;

  BodyBuilder({Key key, this.response, this.child, this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (response == APIRequestStatus.loaded)
      return child;
    else
      return ProgressWidget();
  }
}
