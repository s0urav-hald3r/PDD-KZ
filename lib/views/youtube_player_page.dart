import 'package:exam_app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubePlayerPage extends StatefulWidget {
  final String title;

  const YouTubePlayerPage({super.key, required this.title});

  @override
  State<YouTubePlayerPage> createState() => _YouTubePlayerPageState();
}

class _YouTubePlayerPageState extends State<YouTubePlayerPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    const String youtubeUrl = 'https://www.youtube.com/watch?v=7mKt8Gkwcd8';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(youtubeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              15.w, MediaQuery.of(context).padding.top + 15.h, 25.w, 15.h),
          decoration: BoxDecoration(gradient: containerGradient),
          child: Row(children: [
            InkWell(
              onTap: () {
                NavigatorKey.pop();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 7.5, 0, 7.5),
                child: SvgPicture.asset(backArrowIcon),
              ),
            ),
            const Spacer(),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: whiteColor,
              ),
            ),
            const Spacer(),
          ]),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: whiteColor,
        child: Stack(children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
        ]),
      ),
    );
  }
}
