import 'package:ccp_clean_architecture/core/data/local/shared_preferences/my_shared_preferences.dart';

/// sl = Service Locator

// * Initialization of GetIt service locator or dependency injection
class Injection {
  Injection._();

  static Future<void> init() async {

    // cache storage / Local  database
    await Prefs.init();
    // await MyHive.init();

    // init fcm services
    // await FirebaseInjection.init();

    // initialize local notifications service
    // await AwesomeNotificationsHelper.init();
  }
}
