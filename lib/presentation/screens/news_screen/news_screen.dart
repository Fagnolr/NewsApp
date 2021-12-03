import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/logic/cubit/news_cubit.dart';
import 'package:newsapp/presentation/screens/news_screen/widgets/news_failure.dart';
import 'package:newsapp/presentation/screens/news_screen/widgets/news_loading.dart';
import 'package:newsapp/presentation/screens/news_screen/widgets/news_offline.dart';
import 'package:newsapp/presentation/screens/news_screen/widgets/news_success.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NewsView();
  }
}

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          switch (state.status) {
            case NewsStatus.initial:
              return const NewsFailure();
            case NewsStatus.loading:
              return const NewsLoading();
            case NewsStatus.failure:
              return const NewsFailure();
            case NewsStatus.offline:
              return NewsOffline(news: state.news);
            case NewsStatus.success:
              return NewsSuccess(news: state.news);
            default:
              return const NewsFailure();
          }
        },
      ),
    );
  }
}
