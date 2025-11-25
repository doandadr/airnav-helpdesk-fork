import 'package:envied/envied.dart';

part 'env_config.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class EnvConfig {
  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY', obfuscate: true)
  static final String firebaseAndroidApiKey = _EnvConfig.firebaseAndroidApiKey;

  @EnviedField(varName: 'FIREBASE_ANDROID_APP_ID', obfuscate: true)
  static final String firebaseAndroidAppId = _EnvConfig.firebaseAndroidAppId;

  @EnviedField(varName: 'FIREBASE_IOS_API_KEY', obfuscate: true)
  static final String firebaseIosApiKey = _EnvConfig.firebaseIosApiKey;

  @EnviedField(varName: 'FIREBASE_IOS_APP_ID', obfuscate: true)
  static final String firebaseIosAppId = _EnvConfig.firebaseIosAppId;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID', obfuscate: true)
  static final String firebaseMessagingSenderId =
      _EnvConfig.firebaseMessagingSenderId;

  @EnviedField(varName: 'FIREBASE_PROJECT_ID', obfuscate: true)
  static final String firebaseProjectId = _EnvConfig.firebaseProjectId;

  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET', obfuscate: true)
  static final String firebaseStorageBucket = _EnvConfig.firebaseStorageBucket;

  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID', obfuscate: true)
  static final String firebaseIosBundleId = _EnvConfig.firebaseIosBundleId;

  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _EnvConfig.baseUrl;
}
