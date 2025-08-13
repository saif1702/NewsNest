import 'package:flutter/material.dart';
import '../detail_view.dart';

class NewsContain extends StatelessWidget {
  String imageUrl;
  String newsHead;
  String newsdescrbtion;
  String newsUrl;
  String newsCnt;
  NewsContain({
    super.key,
    required this.imageUrl,
    required this.newsCnt,
    required this.newsdescrbtion,
    required this.newsHead,
    required this.newsUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: "assets/image/placeholder.jpg",
            image: imageUrl,
            width: MediaQuery.of(context).size.width,
            height: 320, // optional, you can remove to make flexible
            fit: BoxFit.cover, // fills the width while keeping aspect ratio
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  newsHead.length > 100
                      ? "${newsHead.substring(0, 99)}...."
                      : newsHead,

                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Text(
                  newsCnt != "__"
                      ? newsCnt.length > 250
                            ? newsCnt.substring(0, 250)
                            : "${newsCnt.toString().substring(0, newsCnt.length - 15)}......"
                      : newsCnt,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  newsdescrbtion,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailViewScreen(newsUrl: newsUrl),
                      ),
                    );
                  },
                  child: Text("READ MORE INFO"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
