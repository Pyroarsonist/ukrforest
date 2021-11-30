import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UkrForestWebView extends StatefulWidget {
  final String barcode;

  @override
  UkrForestWebViewState createState() => UkrForestWebViewState();

  const UkrForestWebView({required this.barcode}) : super();
}

class UkrForestWebViewState extends State<UkrForestWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void simulateJS() async {
    await _controller
        .runJavascript("document.getElementById('birka_check').click()");
    await _controller.runJavascript(
        "document.getElementById('birka_id').value='${widget.barcode}'");
    await _controller
        .runJavascript("document.getElementById('check_birka_button').click()");
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://open.ukrforest.com/',
      onWebViewCreated: (controller) {
        _controller = controller;
      },
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      onPageFinished: (_) {
        simulateJS();
      },
    );
  }
}
