import 'package:dio/dio.dart';
import 'package:newsapp/core/constants/constants.dart';
import 'package:newsapp/data/models/news/news.dart';

class NewsApiProvider {
  Future<News> fetchNews(int index) async {
    var dio = Dio();
    final response = await dio
        .get('${Constants.NEWS_BASE_URL}/top-headlines', queryParameters: {
      "apikey": const String.fromEnvironment('apiKey'),
      "country": "fr",
      "pageSize": 7,
      "page": index
    });
    return News.fromMap(response.data);
  }
}
