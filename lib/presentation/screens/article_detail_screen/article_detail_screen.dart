import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/core/constants/constants.dart';
import 'package:newsapp/data/models/news/article.dart';
import 'package:newsapp/logic/cubit/news_cubit.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/articleDetail';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Article;

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FutureBuilder<bool>(
                  future: BlocProvider.of<NewsCubit>(context)
                      .isFavorite(jsonEncode(args.toMap())),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      return StarButton(
                        isStarred: snapshot.data,
                        valueChanged: (_isFavorite) async {
                          if (_isFavorite) {
                            var imageBase64 =
                                await Constants.networkImageToBase64(args
                                        .urlToImage ??
                                    "https://pleinjour.fr/wp-content/plugins/lightbox/images/No-image-found.jpg");
                            BlocProvider.of<NewsCubit>(context).addData(
                                jsonEncode(args
                                    .copyWith(urlToImage: imageBase64)
                                    .toMap()));
                          } else {
                            BlocProvider.of<NewsCubit>(context)
                                .removeData(jsonEncode(args.toMap()));
                          }
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 200,
                      child: args.isOffline
                          ? SizedBox(
                              child: Constants.imageFromBase64String(
                                  args.urlToImage ?? ""))
                          : Image.network(args.urlToImage ??
                              "https://pleinjour.fr/wp-content/plugins/lightbox/images/No-image-found.jpg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      args.title ?? "",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      args.description ?? "",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        args.source!.name ?? "",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.web_rounded),
                        onPressed: () {
                          BlocProvider.of<NewsCubit>(context)
                              .launchInWebViewWithJavaScript(args.url ?? "");
                        },
                      ),
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          Share.share(
                              'Viens découvrir cet article : ${args.url ?? ""}');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
