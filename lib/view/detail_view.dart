import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class DetailViewScreen extends StatefulWidget {
  final String newsUrl;
  const DetailViewScreen({super.key, required this.newsUrl});

  @override
  State<DetailViewScreen> createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // ✅ Create platform-specific controller params
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = AndroidWebViewControllerCreationParams();
    }

    final webViewController = WebViewController.fromPlatformCreationParams(
      params,
    );

    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    // ✅ Ensure HTTPS
    final secureUrl = widget.newsUrl.startsWith("http:")
        ? widget.newsUrl.replaceFirst("http:", "https:")
        : widget.newsUrl;

    // ✅ Configure WebView
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {},
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {
            debugPrint("WebView error: $error");
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(secureUrl));

    controller = webViewController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NewsNest"), centerTitle: true),
      body: WebViewWidget(controller: controller),
    );
  }
}
