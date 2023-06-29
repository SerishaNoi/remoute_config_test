import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:remoute_config_test/methods/web_view_back_control.dart';

class WebViewScreen extends StatefulWidget {
  final String urlLink;

  const WebViewScreen({
    super.key,
    required this.urlLink,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  double loadingProgress = 0.0;
  int refresProgres = 0;
  late InAppWebViewController inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    pullToRefreshController = PullToRefreshController(
      onRefresh: () => inAppWebViewController.reload(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => exitApp(context, inAppWebViewController),
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(widget.urlLink),
                ),
                onWebViewCreated: (controller) {
                  inAppWebViewController = controller;
                },
                pullToRefreshController: pullToRefreshController,
                onLoadStart: (controller, url) {
                  // проверяем на наличие ссылки в локал сторе, если нет выполняем сохранение
                  // сделать метод в Кубите для этого
                },
                onLoadStop: (controller, url) => pullToRefreshController.endRefreshing(),
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    loadingProgress = progress / 100;
                  });
                },
              ),
              loadingProgress < 1
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: Container(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
