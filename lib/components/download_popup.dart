import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/custom_alert.dart';
import 'package:book_app/util/consts.dart';

class DownloadPopup extends StatefulWidget {
  final String url;
  final String path;

  DownloadPopup({Key key, @required this.url, @required this.path})
      : super(key: key);

  @override
  _DownloadPopupState createState() => _DownloadPopupState();
}

class _DownloadPopupState extends State<DownloadPopup> {
  Dio dio = new Dio();
  int received = 0;
  String progress = '0';
  int total = 0;

  download() async {
    await dio.download(
      widget.url,
      widget.path,
      deleteOnError: true,
      onReceiveProgress: (receivedBytes, totalBytes) {
        setState(() {
          received = receivedBytes;
          total = totalBytes;
          progress = (received / total * 100).toStringAsFixed(0);
        });

        if (receivedBytes == totalBytes) {
          Navigator.pop(context, '${Constants.formatBytes(total, 1)}');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Downloading the book..',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20.0),
              CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
