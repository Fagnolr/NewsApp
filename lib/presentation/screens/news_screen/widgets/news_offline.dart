import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/models/news/article.dart';
import 'package:newsapp/data/models/news/news.dart';
import 'package:newsapp/logic/cubit/news_cubit.dart';
import 'package:newsapp/presentation/screens/article_detail_screen/article_detail_screen.dart';
import 'package:newsapp/presentation/screens/news_screen/widgets/article_item.dart';

class NewsOffline extends StatelessWidget {
  const NewsOffline({
    Key? key,
    required this.news,
  }) : super(key: key);

  final News news;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: Colors.white,
        onRefresh: () {
          return BlocProvider.of<NewsCubit>(context).fetchLocalData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              for (Article article in news.articles!)
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ArticleDetailScreen.routeName,
                      arguments: article.copyWith(isOffline: true)),
                  child: ArticleItem(
                    title: article.title ?? "",
                    source: article.source?.name,
                    url: article.urlToImage ??
                        "https://pleinjour.fr/wp-content/plugins/lightbox/images/No-image-found.jpg",
                    isOffline: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
