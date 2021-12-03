import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Constants {
  static const appTitle = 'News App';

  // ignore: constant_identifier_names
  static const NEWS_BASE_URL = "https://newsapi.org/v2";

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  static Future<String> networkImageToBase64(String imageUrl) async {
    var url = Uri.parse(imageUrl);
    http.Response response = await http.get(url);
    final bytes = response.bodyBytes;
    return (base64Encode(bytes));
  }
}
