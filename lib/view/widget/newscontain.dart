import 'package:flutter/material.dart';
import '../detail_view.dart';

class NewsContain extends StatelessWidget {
  final String imageUrl;
  final String newsHead;
  final String newsdescrbtion;
  final String newsUrl;
  final String newsCnt;

  const NewsContain({
    super.key,
    required this.imageUrl,
    required this.newsCnt,
    required this.newsdescrbtion,
    required this.newsHead,
    required this.newsUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: "assets/image/placeholder.jpg",
            image: imageUrl,
            width: MediaQuery.of(context).size.width,
            height: 280,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsHead.length > 100
                          ? "${newsHead.substring(0, 99)}..."
                          : newsHead,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      newsCnt != "__"
                          ? newsCnt.length > 200
                          ? "${newsCnt.substring(0, 200)}..."
                          : newsCnt
                          : newsCnt,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      newsdescrbtion,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailViewScreen(
                                newsUrl: newsUrl,
                                newsCnt: "$newsHead\n\n$newsCnt\n\n$newsdescrbtion",
                                newsHead: newsHead,
                                newsdescrbtion: newsdescrbtion, newsDescription: '',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "READ MORE INFO",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
