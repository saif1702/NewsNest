import 'package:flutter/material.dart';

class NewsContain extends StatelessWidget {
  String imageUrl;
  String newsHead;
  String newsdescrbtion;
  String newsUrl;
  NewsContain({
    super.key,
    required this.imageUrl,
    required this.newsdescrbtion,
    required this.newsHead,
    required this.newsUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            height: 400,
            width: MediaQuery.of(context).size.width,

            fit: BoxFit.fitWidth,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 22),
                Text(
                  newsHead,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  newsdescrbtion,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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
                    print("goint to $newsUrl");
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
