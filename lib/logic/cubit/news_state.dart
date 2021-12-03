part of 'news_cubit.dart';

enum NewsStatus { initial, loading, success, failure, offline }

class NewsState extends Equatable {
  const NewsState({this.status = NewsStatus.initial, News? news, int? index})
      : news = news ?? const News(),
        index = index ?? 1;

  final NewsStatus status;
  final News news;
  final int index;

  NewsState copyWith({NewsStatus? status, News? news, int? index}) {
    return NewsState(
      status: status ?? this.status,
      news: news ?? this.news,
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [status, news];
}
