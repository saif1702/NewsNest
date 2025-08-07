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

  static NewsArt fromAPItoApp(Map<String, dynamic> artical) {
    return NewsArt(
      imgUrl:
          artical["urlToImage"] ??
          "https://img.freepik.com/free-vector/realistic-news-studio-background_52683-103246.jpg",
      newsCnt: artical["content"] ?? " :-) ",
      newsdescrbtion: artical["description"] ?? " :-) ",
      newsHead: artical["title"] ?? " :-) ",
      newsurl:
          artical["url"] ??
          "https://news.google.com/home?hl=en-US&gl=US&ceid=US:en",
    );
  }
}
