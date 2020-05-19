import 'package:meta/meta.dart';


class NewsModel {
  NewsModel({
    @required this.sourceName,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlImage,
    @required this.publishedAt,
    @required this.content
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      sourceName: json['source']['name'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content']
    );
  }
 
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlImage;
  final String publishedAt;
  final String content;
}