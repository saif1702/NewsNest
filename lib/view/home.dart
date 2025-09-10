import 'package:flutter/material.dart';
import 'package:newsnest/model/newsArt.dart';
import 'package:newsnest/view/widget/newscontain.dart';
import '../controller/newsfatch.dart';
import 'category_bar.dart';
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
  bool isSearching = false;

  String selectedCategory = "Top News";

  final Map<String, String> categoryMap = {
    "Top News": "general",
    "Sport": "sports",
    "Politics": "business",
    "World": "",
    "Finance": "business",
    "Health": "health",
    "Technology": "technology",
  };

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews({String? category}) async {
    setState(() {
      isLoading = true;
      isSearching = false;
    });

    try {
      allNews = await NewsFatch.getTopHeadlines(
        pageSize: 20,
        category: category,
      );
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> performSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      isSearching = true;
      selectedCategory = "";
    });

    try {
      searchResults = await NewsFatch.searchNews(query);
    } catch (e) {
      print("Search error: $e");
    } finally {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
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
        elevation: 0,
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
      body: Stack(
        children: [
          Column(
            children: [
              // 🔍 Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => performSearch(searchController.text),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                        child: const Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) => performSearch(value),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search News...",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 📰 News List
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : displayList.isEmpty
                    ? const Center(child: Text("No news found"))
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
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

          // 📌 CategoryBar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: CategoryBar(
                categories: categoryMap.keys.toList(),
                selectedCategory: selectedCategory,
                onCategorySelected: (selectedItem) {
                  setState(() {
                    selectedCategory = selectedItem;
                  });

                  final apiCategory = categoryMap[selectedItem]!;

                  if (apiCategory.isNotEmpty) {
                    getNews(category: apiCategory);
                  } else {
                    performSearch(selectedItem);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
