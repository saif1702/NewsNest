import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:newsnest/model/newsArt.dart';

class NewsFatch {
  static List sourcesId = [
    "business-insider-uk",
    "cbc-news",
    "cbs-news",
    "channel-news-asia",
    "cnn",
    "cnn-es",
    "der-tagesspiegel",
    "die-zeit",
    "el-mundo",
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
    "bild",
    "bleacher-report",
    "bloomberg",
    "breitbart-news",
    "buzzfeed",
    "business-insider",
    "fox-sports",
    "globo",
    "google-news",
    "google-news-in",
    "guardian-uk",
    "hacker-news",
    "ign",
    "independent",
    "les-echos",
    "medical-news-today",
    "msnbc",
    "mtv-news",
    "national-geographic",
    "news24",
    "new-scientist",
    "new-york-magazine",
    "next-big-future",
    "newsweek",
    "npr",
    "politico",
    "recode",
    "rediff",
    "reuters",
    "techcrunch",
    "techradar",
    "thedailybeast",
    "the-economist",
    "the-globe-and-mail",
    "the-hindu",
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
    "ynet",
    "abc-news-au",
    "business-insider-de",
    "cbc-news",
    "washington-examiner",
    "yahoo-news",
    "yahoo-sports",
    "yahoo-finance",
    "the-huffington-post",
    "mirror-sport",
    "guardian-au",
    "guardian-de",
    "guardian-us",
    "guardian-in",
    "guardian-za",
    "guardian-ca",
    "crypto-news",
    "daily-mail",
    "daily-mirror",
    "daily-telegraph-au",
    "der-spiegel",
    "economic-times",
    "el-pais",
    "espn-fc",
    "evening-standard",
    "global-times",
    "i-news",
    "inews",
    "india-today",
    "kicking-world",
    "le-monde",
    "metro",
    "news-com-au",
    "nz-herald",
    "nsw-news",
    "the-straits-times",
    "tokyo-np",
    "tokyo-sports",
    "tokyo-express",
    "times-of-india",
    "usatoday-sports",
    "guardian-au",
    "guardian-kr",
    "guardian-jp",
    "guardian-ru",
    "the-guardian-science",
    "guangming-daily",
  ];

  static Future<NewsArt> Newsfatch() async {
    try {
      final _random = Random();
      var sourceID = sourcesId[_random.nextInt(sourcesId.length)];
      print("Fetching from source: $sourceID");

      final response = await get(
        Uri.parse(
          "https://newsapi.org/v2/top-headlines?sources=$sourcesId&apiKey=780937c2368a4fb49b1b328004d37b32",
        ),
      );

      if (response.statusCode != 200) {
        throw Exception("HTTP ${response.statusCode}: ${response.body}");
      }

      Map<String, dynamic> body_data = jsonDecode(response.body);
      List articles = body_data["articles"] ?? [];

      if (articles.isEmpty) {
        throw Exception("No articles found");
      }

      var myArticle = articles[_random.nextInt(articles.length)];
      print("Fetched article: ${myArticle['title']}");

      return NewsArt.fromAPItoApp(myArticle);
    } catch (e) {
      print("API error: $e");
      rethrow;
    }
  }
}
