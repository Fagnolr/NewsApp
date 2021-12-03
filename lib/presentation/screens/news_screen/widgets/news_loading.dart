import 'package:flutter/material.dart';

class NewsLoading extends StatelessWidget {
  const NewsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:
          SizedBox(height: 60, width: 60, child: CircularProgressIndicator()),
    );
  }
}
