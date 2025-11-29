import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'webview_controller.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final url = Get.arguments['url'];
    final onNavigationRequest = Get.arguments['onNavigationRequest'];
    final controller = Get.put(
      WebviewController(
        initialUrl: url,
        onNavigationRequest: onNavigationRequest,
      ),
    );

    return Scaffold(
      // appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: Obx(() {
        return Stack(
          children: [
            WebViewWidget(controller: controller.controller),
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      }),
    );
  }
}
