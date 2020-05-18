import 'package:flutter/foundation.dart';

class NewsModel {
  final String sourceName;
  final String author;
  final String urlImage;

  NewsModel(
      {@required this.sourceName,
      @required this.author,
      @required this.urlImage});
}
