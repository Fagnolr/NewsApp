import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'article.dart';

class News extends Equatable {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  const News({this.status, this.totalResults, this.articles});

  factory News.fromMap(Map<String, dynamic> data) => News(
        status: data['status'] as String?,
        totalResults: data['totalResults'] as int?,
        articles: (data['articles'] as List<dynamic>?)
            ?.map((e) => Article.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [News].
  factory News.fromJson(String data) {
    return News.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [News] to a JSON string.
  String toJson() => json.encode(toMap());

  News copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) {
    return News(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props => [status, totalResults, articles];
}
