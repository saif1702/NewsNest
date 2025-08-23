class NewsArt {
  String imgUrl;
  String newsHead;
  String newsdescrbtion;
  String newsCnt;
  String newsurl;

  NewsArt({
    required this.imgUrl,
    required this.newsCnt,
    required this.newsdescrbtion,
    required this.newsHead,
    required this.newsurl,
  });

  String get newsId => newsurl.hashCode.toString();

  static NewsArt fromAPItoApp(Map<String, dynamic> article) {
    return NewsArt(
      imgUrl:
          article["urlToImage"] ??
          "https://img.freepik.com/free-vector/realistic-news-studio-background_52683-103246.jpg",
      newsCnt: article["content"] ?? "No content",
      newsdescrbtion: article["description"] ?? "No description",
      newsHead: article["title"] ?? "No title",
      newsurl: article["url"] ?? "https://news.google.com/home",
    );
  }
}
