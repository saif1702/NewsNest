import 'dart:convert';
import 'package:flutter/services.dart';

class GeminiService {
  final String serviceAccountPath;

  GeminiService(this.serviceAccountPath);

  Future<Map<String, dynamic>> _loadServiceAccount() async {
    final jsonString = await rootBundle.loadString(serviceAccountPath);
    return jsonDecode(jsonString);
  }

  Future<String> process(String action, String content) async {

    await Future.delayed(const Duration(seconds: 2));

    switch (action.toLowerCase()) {
      case 'summarize':
        return "Summary:\n${content.substring(0, content.length > 100 ? 100 : content.length)}...";
      case 'explain':
        return "Explanation:\nThis content talks about: ${content.split(' ').take(10).join(' ')}...";
      case 'translate':
        return "Translation (mock):\n${content.split('').reversed.join()}";
      case 'q&a':
        return "Q&A (mock):\nQuestion: What is this about?\nAnswer: ${content.split(' ').take(5).join(' ')}...";
      default:
        return "Action '$action' is not supported.";
    }
  }
}
