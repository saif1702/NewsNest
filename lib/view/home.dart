import 'package:flutter/material.dart';
import 'package:newsnest/view/widget/newscontain.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    NewsFatch.newsfatch();a
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return NewsContain(
            imageUrl:
                "https://images.unsplash.com/photo-1593789198777-f29bc259780e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            newsdescrbtion:
                "Hypersomnia is excessive sleepiness. There are many causes of excessive sleepiness, including insufficient or inadequate sleep, sleep disorders, medications and medical or psychiatric illnesses.",
            newsHead: "why people just wanna sleep? ",
            newsUrl:
                "https://www.betterhealth.vic.gov.au/health/conditionsandtreatments/sleep-hypersomnia",
          );
        },
      ), // helps to scroll pages horizontally
    );
  }
}
