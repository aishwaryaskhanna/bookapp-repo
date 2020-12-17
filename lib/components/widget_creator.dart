import 'package:flutter/material.dart';
import 'package:book_app/components/progress_widget.dart';
import 'package:book_app/util/request_status.dart';

class WidgetCreator extends StatelessWidget {
  final Request status;
  final Widget childWidget;
  final Function reload;

  WidgetCreator({Key key, this.status, this.childWidget, this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == Request.loaded)
      return childWidget;
    else
      return ProgressWidget();
  }
}
