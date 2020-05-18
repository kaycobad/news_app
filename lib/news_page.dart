import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatelessWidget {
  final String newsUrl;
  NewsPage({@required this.newsUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: WebView(
          initialUrl: newsUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
