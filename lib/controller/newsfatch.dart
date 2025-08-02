https://newsapi.org/v2/top-headlines/sources?apiKey=0f7a5f9303f0486dbdd4c80ec54c9753
import 'dart:convert';

import 'package:http/http.dart';

class NewsFatch{
  static NewsFatch() async{
    List sources = [];
    Response response = await get(uri.parse(
        "https://newsapi.org/v2/top-headlines/sources?apiKey=0f7a5f9303f0486dbdd4c80ec54c9753"))

    Map body data= jsonDecode(response.body);
    print(body_data)
  }
}