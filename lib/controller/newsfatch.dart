import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsnest/model/newsArt.dart';

class NewsFatch {
  static const String apiKey = "780937c2368a4fb49b1b328004d37b32";
  static const String countryCode = "US";

  static Future<List<NewsArt>> getTopHeadlines({
    required int pageSize,
    String? category,
  }) async {
    try {

      final localUrl = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=$countryCode"
        "${category != null ? "&category=$category" : ""}"
        "&pageSize=$pageSize&apiKey=$apiKey",
      );

      final globalUrl = Uri.parse(
        "https://newsapi.org/v2/top-headlines?language=en"
        "${category != null ? "&category=$category" : ""}"
        "&pageSize=$pageSize&apiKey=$apiKey",
      );

      final localResp = await http.get(localUrl);
      final globalResp = await http.get(globalUrl);

      if (localResp.statusCode != 200 || globalResp.statusCode != 200) {
        throw Exception("Failed to fetch news");
      }

      List localArticles = jsonDecode(localResp.body)["articles"] ?? [];
      List globalArticles = jsonDecode(globalResp.body)["articles"] ?? [];

      final allArticles = [...localArticles, ...globalArticles];
      final seenUrls = <String>{};
      final filtered = allArticles.where((article) {
        final url = article["url"] ?? "";
        if (seenUrls.contains(url)) return false;
        seenUrls.add(url);
        return true;
      }).toList();

      return filtered.map((a) => NewsArt.fromAPItoApp(a)).toList();
    } catch (e) {
      print("Error fetching top headlines: $e");
      rethrow;
    }
  }

  static Future<List<NewsArt>> searchNews(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&language=en&apiKey=$apiKey",
        ),
      );

      if (response.statusCode != 200) {
        throw Exception("HTTP ${response.statusCode}");
      }

      List articles = jsonDecode(response.body)["articles"] ?? [];
      return articles.map((a) => NewsArt.fromAPItoApp(a)).toList();
    } catch (e) {
      print("Search API error: $e");
      rethrow;
    }
  }
}
