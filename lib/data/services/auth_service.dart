import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  Future<dynamic> login() async {
    final url =
        'https://auth.airnavindonesia.co.id/?redirect_uri=aHR0cDovL2xvY2FsaG9zdDozMDAwL2F1dGhoZWxwZGVzaw==';
    return await Get.toNamed(
      Routes.WEBVIEW,
      arguments: {
        'url': url,
        'onNavigationRequest': (NavigationRequest request) {
          if (request.url.startsWith('http://localhost:3000/authhelpdesk')) {
            final uri = Uri.parse(request.url);
            final token = uri.pathSegments.last;
            Get.back(result: token);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      },
    );
  }
}
