import 'package:newsapp/data/data_provider/news_api_provider.dart';
import 'package:newsapp/data/models/news/news.dart';

class NewsRepository {
  NewsRepository({NewsApiProvider? newsApi})
      : _newsApiProvider = newsApi ?? NewsApiProvider();

  final NewsApiProvider _newsApiProvider;

  Future<News> fetchNews(int index) async {
    return _newsApiProvider.fetchNews(index);
  }
}
