import 'package:flutter/material.dart';

class BookDescriptionWidget extends StatefulWidget {
  final String text;

  BookDescriptionWidget({@required this.text});

  @override
  _BookDescriptionWidgetState createState() => _BookDescriptionWidgetState();
}

class _BookDescriptionWidgetState extends State<BookDescriptionWidget> {
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
