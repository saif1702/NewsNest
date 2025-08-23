import 'package:flutter/material.dart';
import 'package:newsnest/model/newsArt.dart';
import 'package:newsnest/view/widget/newscontain.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Simple in-memory list of saved news
  static final List<NewsArt> savedNews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🔔 Notifications"), centerTitle: true),
      body: savedNews.isEmpty
          ? const Center(
              child: Text(
                "No new notifications yet",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: savedNews.length,
              itemBuilder: (context, index) {
                final news = savedNews[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: NewsContain(
                    imageUrl: news.imgUrl,
                    newsCnt: news.newsCnt,
                    newsHead: news.newsHead,
                    newsdescrbtion: news.newsdescrbtion,
                    newsUrl: news.newsurl,
                  ),
                );
              },
            ),
    );
  }
}
