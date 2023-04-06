import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class Initializer {
  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await _initStorage();
      _initScreenPreference();
    } catch (err) {
      rethrow;
    }
  }



  static Future<void> _initStorage() async {
    await GetStorage.init();
    Get.put(GetStorage());
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
