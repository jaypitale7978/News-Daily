import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../app/styles/app_colors.dart';
import '../../../app/styles/app_size.dart';
import '../../../app/styles/app_text_styel.dart';
import '../../../core/const/animations/animations.dart';

class ArticleWebViewPage extends StatefulWidget {
  final String url;

  const ArticleWebViewPage({
    super.key,
    required this.url,
  });

  @override
  State<ArticleWebViewPage> createState() => _ArticleWebViewPageState();
}

class _ArticleWebViewPageState extends State<ArticleWebViewPage> {
  late final WebViewController controller;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });

            debugPrint('Page started: $url');
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });

            debugPrint('Page finished: $url');
          },
          onWebResourceError: (error) {
            setState(() {
              isLoading = false;
            });

            debugPrint(
              'WebView error: ${error.description}',
            );
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'News',
              style: AppTextStyle.headerTitle.copyWith(
                color: AppColors.headerTitle,
              ),
            ),

            const SizedBox(
              width: AppSize.width10,
            ),

            Text(
              'Daily',
              style: AppTextStyle.headerTitle.copyWith(
                color: AppColors.red,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),

          if (isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: Lottie.asset(
                  Animations.loadingAnimation,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
        ],
      ),
    );
  }
}