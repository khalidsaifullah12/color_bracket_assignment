import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  String url;
  WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

final Completer<WebViewController> _controller =
Completer<WebViewController>();
double _progress = 0;

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Stack(
        children: [
        WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },

          onProgress: (int progress) {

          setState(() {
            _progress=progress.toDouble();

          });

    },
        ),

      _progress < 1
          ? SizedBox(
        height: 5,
        child: LinearProgressIndicator(
          value: _progress.toDouble(),
          backgroundColor: Colors.deepOrangeAccent,
        ),
      )
          : Container()

        ],
      ),
    );
  }
}
