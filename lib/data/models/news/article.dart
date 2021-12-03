import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'source.dart';

// ignore: must_be_immutable
class Article extends Equatable {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  String? urlToImage;
  final DateTime? publishedAt;
  final String? content;
  bool isOffline;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.isOffline = false,
  });

  factory Article.fromMap(Map<String, dynamic> data) => Article(
        source: data['source'] == null
            ? null
            : Source.fromMap(data['source'] as Map<String, dynamic>),
        author: data['author'] as String?,
        title: data['title'] as String?,
        description: data['description'] as String?,
        url: data['url'] as String?,
        urlToImage: data['urlToImage'] as String?,
        publishedAt: data['publishedAt'] == null
            ? null
            : DateTime.parse(data['publishedAt'] as String),
        content: data['content'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'source': source?.toMap(),
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt?.toIso8601String(),
        'content': content,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Article].
  factory Article.fromJson(String data) {
    return Article.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Article] to a JSON string.
  String toJson() => json.encode(toMap());

  Article copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
    bool? isOffline,
  }) {
    return Article(
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
        isOffline: isOffline ?? this.isOffline);
  }

  @override
  List<Object?> get props {
    return [
      source,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }
}
