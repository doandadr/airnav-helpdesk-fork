import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'webview_controller.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    final url = arg is Map ? arg['url'] : 'https://flutter.dev';
    final controller = Get.put(WebviewController(initialUrl: url));

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(controller: controller.controller),
    );
  }
}
