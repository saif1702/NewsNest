import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/gemini_service.dart';

class DetailViewScreen extends StatefulWidget {
  final String newsUrl;
  final String newsCnt;
  final String newsHead;
  final String newsDescription;

  const DetailViewScreen({
    super.key,
    required this.newsUrl,
    required this.newsCnt,
    required this.newsHead,
    required this.newsDescription, required String newsdescrbtion,
  });

  @override
  State<DetailViewScreen> createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  late WebViewController controller;
  late GeminiService _gemini;

  String aiResult = "";
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.newsUrl));

    _gemini = GeminiService("assets/service-account.json");
  }

  void callAI(String action) async {
    setState(() {
      isProcessing = true;
      aiResult = "";
    });

    try {
      String content =
          "${widget.newsHead}\n\n${widget.newsCnt}\n\n${widget.newsDescription}";

      String prompt = action == "Summarize"
          ? "Summarize the following news in about 100 words:\n$content"
          : action == "Translate"
          ? "Translate the following news into Bangla:\n$content"
          : "$action:\n$content";

      final result = await _gemini.process(action, prompt);

      setState(() {
        aiResult = result;
      });
    } catch (e) {
      setState(() {
        aiResult = "AI processing failed: $e";
      });
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  void showAIOptions() {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000, 80, 10, 0),
      items: [
        PopupMenuItem(value: 'Summarize', child: const Text('Summarize')),
        PopupMenuItem(value: 'Explain', child: const Text('Explain')),
        PopupMenuItem(value: 'Translate', child: const Text('Translate')),
      ],
    ).then((value) {
      if (value != null) {
        callAI(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "📰 NewsNest",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.smart_toy),
            onPressed: showAIOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
          if (isProcessing)
            const LinearProgressIndicator(color: Colors.blueAccent),
          if (aiResult.isNotEmpty)
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueAccent),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: SingleChildScrollView(
                child: Text(
                  aiResult,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
