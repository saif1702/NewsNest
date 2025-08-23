import 'package:flutter/material.dart';
import 'package:newsnest/model/newsArt.dart';
import '../controller/newsfatch.dart';
import '../view/widget/newscontain.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = true;
  List<NewsArt> searchResults = [];

  Future<void> fetchSearchResults() async {
    try {
      final results = await NewsFatch.searchNews(widget.query);

      if (!mounted) return;
      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      print("Error fetching search results: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results for \"${widget.query}\""),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : searchResults.isEmpty
          ? const Center(
              child: Text("No results found", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final news = searchResults[index];
                return NewsContain(
                  imageUrl: news.imgUrl,
                  newsCnt: news.newsCnt,
                  newsHead: news.newsHead,
                  newsdescrbtion: news.newsdescrbtion,
                  newsUrl: news.newsurl,
                );
              },
            ),
    );
  }
}
