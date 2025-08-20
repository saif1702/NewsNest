// lib/view/home.dart
import 'package:flutter/material.dart';
import 'package:newsnest/model/newsArt.dart';
import 'package:newsnest/view/widget/newscontain.dart';
import '../controller/newsfatch.dart';
import '../notification.dart';
import 'notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  late NewsArt newsArt;

  Future<void> getNews() async {
    try {
      newsArt = await NewsFatch.Newsfatch();

      // Only update state if the widget is still mounted
      if (!mounted) return;

      setState(() {
        isLoading = false;

        // Safely update currentNewsId if it's not null
        if (newsArt.newsId != null) {
          currentNewsId = newsArt.newsId;
        }
      });
    } catch (e, stacktrace) {
      // Handle errors gracefully
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print("Error fetching news: $e");
      print(stacktrace);
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        onPageChanged: (index) async {
          setState(() => isLoading = true);
          await getNews();
        },
        itemBuilder: (context, index) {
          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : NewsContain(
                  imageUrl: newsArt.imgUrl,
                  newsCnt: newsArt.newsCnt,
                  newsHead: newsArt.newsHead,
                  newsdescrbtion: newsArt.newsdescrbtion,
                  newsUrl: newsArt.newsurl,
                );
        },
      ),
    );
  }
}
