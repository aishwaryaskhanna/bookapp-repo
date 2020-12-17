import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/custom_alert.dart';

class DownloadModal extends StatefulWidget {
  final String bookUrl;
  final String path;

  DownloadModal({Key key, this.bookUrl, this.path}) : super(key: key);

  @override
  _DownloadModalState createState() => _DownloadModalState();
}

class _DownloadModalState extends State<DownloadModal> {
  Dio dio = new Dio();
  int receivedBytes = 0;
  int totalBytes = 0;
  String downloadProgress = '0';

  startDownload() async {
    await dio.download(
      widget.bookUrl,
      widget.path,
      deleteOnError: true,
      onReceiveProgress: (received, total) {
        setState(() {
          receivedBytes = received;
          totalBytes = total;
          downloadProgress =
              (receivedBytes / totalBytes * 100).toStringAsFixed(0);
        });

        if (received == total) {
          print("Complete.");
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startDownload();
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
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 18.0),
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
