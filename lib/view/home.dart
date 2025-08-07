import 'package:flutter/material.dart';
import 'package:newsnest/model/newsArt.dart';
import 'package:newsnest/view/widget/newscontain.dart';
import '../controller/newsfatch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  late NewsArt newsArt;
  GetNews() async {
    newsArt = await NewsFatch.Newsfatch();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          setState(() {
            isLoading = true;
          });
          GetNews();
        },
        itemBuilder: (context, index) {
          return isLoading
              ? Center(child: CircularProgressIndicator())
              : NewsContain(
                  imageUrl: newsArt.imgUrl,
                  newsCnt: newsArt.newsCnt,
                  newsHead: newsArt.newsHead,
                  newsdescrbtion: newsArt.newsdescrbtion,
                  newsUrl: newsArt.newsurl,
                );
        },
      ), // helps to scroll pages horizontally
    );
  }
}
