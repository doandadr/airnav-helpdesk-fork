import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:airnav_helpdesk/data/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  Future<dynamic> login() async {
    final url =
        'https://auth.airnavindonesia.co.id/?redirect_uri=aHR0cDovL2xvY2FsaG9zdDozMDAwL2F1dGhoZWxwZGVzaw==';
    final result = await Get.toNamed(
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
    print('Login result: $result');
    if (result != null && result is String) {
      try {
        await Get.find<StorageService>().saveToken(result);
      } catch (_) {
        // ignore errors when storage service is not available
      }
    }

    return result;
  }
}
