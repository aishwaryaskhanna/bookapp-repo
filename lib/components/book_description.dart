import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String description;
  @override
  void initState() {
    super.initState();
    description = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '${(description)}'
            .replaceAll(r'\n', '\n')
            .replaceAll(r'\r', '')
            .replaceAll(r"\'", "'"),
        style: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).textTheme.caption.color,
        ),
      ),
    );
  }
}
