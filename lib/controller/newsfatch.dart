import 'dart:convert';
import 'package:http/http.dart';
import 'package:newsnest/model/newsArt.dart';

class NewsFatch {
  static const String apiKey = "780937c2368a4fb49b1b328004d37b32";
  static const String countryCode = "bd"; // your country

  // Top headlines (local + global)
  static Future<List<NewsArt>> getTopHeadlines({required int pageSize}) async {
    try {
      // Local news
      final localResp = await get(
        Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$apiKey",
        ),
      );
      // Global news
      final globalResp = await get(
        Uri.parse(
          "https://newsapi.org/v2/top-headlines?language=en&apiKey=$apiKey",
        ),
      );

      if (localResp.statusCode != 200 || globalResp.statusCode != 200) {
        throw Exception("Failed to fetch news");
      }

      List localArticles = jsonDecode(localResp.body)["articles"] ?? [];
      List globalArticles = jsonDecode(globalResp.body)["articles"] ?? [];

      // Merge and convert to NewsArt
      List<NewsArt> allNews = [
        ...localArticles.map((a) => NewsArt.fromAPItoApp(a)),
        ...globalArticles.map((a) => NewsArt.fromAPItoApp(a)),
      ];

      return allNews;
    } catch (e) {
      print("Error fetching top headlines: $e");
      rethrow;
    }
  }

  // Search news
  static Future<List<NewsArt>> searchNews(String query) async {
    try {
      final response = await get(
        Uri.parse(
          "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&language=en&apiKey=$apiKey",
        ),
      );

      if (response.statusCode != 200)
        throw Exception("HTTP ${response.statusCode}");

      List articles = jsonDecode(response.body)["articles"] ?? [];
      return articles.map((a) => NewsArt.fromAPItoApp(a)).toList();
    } catch (e) {
      print("Search API error: $e");
      rethrow;
    }
  }
}
