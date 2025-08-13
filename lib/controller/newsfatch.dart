import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:newsnest/model/newsArt.dart';

class NewsFatch {
  static List sourcesId = [
    "business-insider-uk",
    "cbc-news",
    "cbs-news",
    "cnn",
    "engadget",
    "entertainment-weekly",
    "espn",
    "espn-cric-info",
    "financial-post",
    "financial-times",
    "fortune",
    "fox-news",
    "abc-news",
    "al-jazeera-english",
    "associated-press",
    "bleacher-report",
    "bloomberg",
    "breitbart-news",
    "buzzfeed",
    "business-insider",
    "fox-sports",
    "google-news",
    "guardian-uk",
    "hacker-news",
    "ign",
    "independent",
    "medical-news-today",
    "msnbc",
    "mtv-news",
    "national-geographic",
    "new-scientist",
    "new-york-magazine",
    "next-big-future",
    "newsweek",
    "npr",
    "politico",
    "recode",
    "reuters",
    "techcrunch",
    "techradar",
    "thedailybeast",
    "the-economist",
    "the-hill",
    "the-irish-times",
    "the-jerusalem-post",
    "the-lad-bible",
    "the-new-york-times",
    "the-next-web",
    "the-sport-bible",
    "the-telegraph",
    "the-verge",
    "the-wall-street-journal",
    "the-washington-post",
    "the-washington-times",
    "time",
    "usa-today",
    "vice-news",
    "wired",
    "abc-news-au",
    "washington-examiner",
    "yahoo-news",
    "yahoo-sports",
    "yahoo-finance",
    "the-huffington-post",
    "mirror-sport",
    "guardian-au",
    "guardian-us",
    "guardian-in",
    "guardian-za",
    "guardian-ca",
    "crypto-news",
    "daily-mail",
    "daily-mirror",
    "daily-telegraph-au",
    "evening-standard",
    "i-news",
    "inews",
    "metro",
    "news-com-au",
    "nz-herald",
    "nsw-news",
    "usatoday-sports",
    "the-guardian-science",
  ];

  static Future<NewsArt> Newsfatch() async {
    try {
      final random = Random();
      var sourceID = sourcesId[random.nextInt(sourcesId.length)];
      print("Fetching from source: $sourceID");

      final response = await get(
        Uri.parse(
          "https://newsapi.org/v2/top-headlines?sources=$sourcesId&apiKey=780937c2368a4fb49b1b328004d37b32",
        ),
      );

      if (response.statusCode != 200) {
        throw Exception("HTTP ${response.statusCode}: ${response.body}");
      }

      Map<String, dynamic> bodyData = jsonDecode(response.body);
      List articles = bodyData["articles"] ?? [];

      if (articles.isEmpty) {
        throw Exception("No articles found");
      }

      var myArticle = articles[random.nextInt(articles.length)];
      print("Fetched article: ${myArticle['title']}");

      return NewsArt.fromAPItoApp(myArticle);
    } catch (e) {
      print("API error: $e");
      rethrow;
    }
  }
}
