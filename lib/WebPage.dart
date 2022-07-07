import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

late WebViewController _controller;

class WebPage extends StatefulWidget {
  const WebPage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {

  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Full Article",
          textAlign: TextAlign.center,),
      ),
      body: _buildWebBody(context, widget.url),
    );// This trailing comma makes auto-formatting nicer for build metho
  }

  // _loadHtmlFromAssets(String url) async {
  //   String fileText = await rootBundle.loadString('assets/files/' + product.bRANDNAME.toString() + " " +
  //       product.pRODUCTFORM.toString() + '.html');
  //   _controller.loadUrl( Uri.dataFromString(
  //       fileText,
  //       mimeType: 'text/html',
  //       encoding: Encoding.getByName('utf-8')
  //   ).toString());
  // }

  Widget _buildWebBody(BuildContext context, String url) {
    return Container(
        child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted
        )
    );
  }
}