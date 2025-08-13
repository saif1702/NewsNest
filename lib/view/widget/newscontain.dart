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
          Image.network(
            imageUrl,
            height: 380,
            width: MediaQuery.of(context).size.width,

            fit: BoxFit.fitWidth,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 19),
                Text(
                  newsHead.length > 50
                      ? "${newsHead.substring(0, 50)}...."
                      : newsHead,

                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  newsCnt.length > 250
                      ? newsCnt.substring(0, 250)
                      : "${newsCnt.toString().substring(0, newsCnt.length - 15)}......",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  newsdescrbtion,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
