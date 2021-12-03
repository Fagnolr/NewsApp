import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/data/models/news/article.dart';
import 'package:newsapp/data/models/news/news.dart';
import 'package:newsapp/data/repository/news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._newsRepository) : super(const NewsState());

  final NewsRepository _newsRepository;

  Future<void> fetchNews(int index) async {
    emit(state.copyWith(status: NewsStatus.loading));

    try {
      final news = await _newsRepository.fetchNews(index);
      emit(
          state.copyWith(status: NewsStatus.success, news: news, index: index));
    } on DioError {
      await fetchLocalData();
    } catch (e) {
      emit(state.copyWith(status: NewsStatus.failure));
    }
  }

  Future<void> fetchLocalData() async {
    emit(state.copyWith(status: NewsStatus.loading));
    try {
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      List<String>? articleList = sharedPrefs.getStringList('articlesaved');
      if (articleList == null) {
        emit(state.copyWith(status: NewsStatus.initial));
        return;
      } else {
        List<Article> tmp = [];
        for (String data in articleList) {
          tmp.add(Article.fromMap(json.decode(data)));
        }
        if (tmp.isEmpty) {
          emit(state.copyWith(status: NewsStatus.failure));
        } else {
          emit(state.copyWith(
              status: NewsStatus.offline, news: News(articles: tmp)));
        }
      }
    } on Exception {
      emit(state.copyWith(status: NewsStatus.failure));
    }
  }

  Future<bool> isFavorite(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var articleList = prefs.getStringList('articlesaved');
    if (articleList == null) {
      return false;
    } else {
      for (var article in articleList) {
        if (article.contains(data.substring(0, 100))) return true;
      }
    }
    return false;
  }

  Future<void> addData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var articleList = prefs.getStringList('articlesaved');
    if (articleList == null) {
      articleList = [];
      articleList.add(data);
    } else {
      articleList.add(data);
    }
    await prefs.setStringList('articlesaved', articleList);
  }

  Future<void> removeData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var articleList = prefs.getStringList('articlesaved');
    if (articleList == null) {
      return;
    } else {
      articleList
          .removeWhere((element) => element.contains(data.substring(0, 100)));
    }
    await prefs.setStringList('articlesaved', articleList);
  }

  Future<void> launchInWebViewWithJavaScript(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    )) {
      throw 'Could not launch $url';
    }
  }
}
