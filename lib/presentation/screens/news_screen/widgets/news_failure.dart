import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/logic/cubit/news_cubit.dart';

class NewsFailure extends StatelessWidget {
  const NewsFailure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      onRefresh: () {
        return BlocProvider.of<NewsCubit>(context)
            .fetchNews(BlocProvider.of<NewsCubit>(context).state.index);
      },
      child: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '🙈',
              style: TextStyle(fontSize: 64),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Something went wrong!',
            ),
          ),
        ],
      ),
    );
  }
}
