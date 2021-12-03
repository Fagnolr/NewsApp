import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/core/constants/constants.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem(
      {Key? key,
      required this.title,
      required this.source,
      required this.url,
      this.isOffline = false})
      : super(key: key);

  final String title;
  final String? source;
  final String url;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0x901A1E25),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              isOffline
                  ? SizedBox(child: Constants.imageFromBase64String(url))
                  : SizedBox(child: Image.network(url)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 8, left: 8, right: 8),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  source ?? "",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
