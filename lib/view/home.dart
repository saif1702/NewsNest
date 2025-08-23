import 'package:flutter/material.dart';
import 'package:newsnest/model/newsArt.dart';
import 'package:newsnest/view/widget/newscontain.dart';
import '../controller/newsfatch.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<NewsArt> allNews = [];
  List<NewsArt> searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false; // true when showing search results

  @override
  void initState() {
    super.initState();
    getNews();
  }

  // Fetch top headlines (20 articles)
  Future<void> getNews() async {
    try {
      allNews = await NewsFatch.getTopHeadlines(pageSize: 20);
      if (!mounted) return;
      setState(() {
        isLoading = false;
        isSearching = false; // show normal news
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print("Error fetching news: $e");
    }
  }

  // Perform search using API
  Future<void> performSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      searchResults = await NewsFatch.searchNews(query);
      if (!mounted) return;
      setState(() {
        isLoading = false;
        isSearching = true; // show search results
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print("Search error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<NewsArt> displayList = isSearching ? searchResults : allNews;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("📰 NewsNest", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    performSearch(searchController.text);
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                    child: const Icon(Icons.search, color: Colors.blueAccent),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      performSearch(value);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Health",
                    ),
                  ),
                ),
              ],
            ),
          ),

          // News List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : displayList.isEmpty
                ? const Center(child: Text("No news found"))
                : ListView.builder(
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final news = displayList[index];
                      return NewsContain(
                        imageUrl: news.imgUrl,
                        newsCnt: news.newsCnt,
                        newsHead: news.newsHead,
                        newsdescrbtion: news.newsdescrbtion,
                        newsUrl: news.newsurl,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
