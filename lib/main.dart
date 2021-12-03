import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/repository/news_repository.dart';
import 'package:newsapp/logic/cubit/news_cubit.dart';
import 'package:newsapp/presentation/screens/article_detail_screen/article_detail_screen.dart';

import 'presentation/screens/news_screen/news_screen.dart';

void main() {
  runApp(NewsApp(newsRepository: NewsRepository()));
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key, required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(key: key);

  final NewsRepository _newsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _newsRepository,
      child: BlocProvider(
        create: (context) =>
            NewsCubit(context.read<NewsRepository>())..fetchNews(1),
        child: MaterialApp(
          routes: {
            ArticleDetailScreen.routeName: (context) =>
                const ArticleDetailScreen(),
          },
          title: 'Flutter Demo',
          theme: ThemeData.dark(),
          home: const NewsScreen(),
        ),
      ),
    );
  }
}
