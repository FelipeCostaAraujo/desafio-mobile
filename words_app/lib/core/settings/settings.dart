import 'package:firebase_remote_config/firebase_remote_config.dart';

class Settings {
  static String rapidAPIKey = "";
  static String rapidAPIHost = "";

  static Future<void> init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    rapidAPIKey = remoteConfig.getString('RapidKey');
    rapidAPIHost = remoteConfig.getString('RapidHost');
  }
}
