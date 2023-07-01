import 'package:admin/screens/login/login_V5.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:fluro/fluro.dart';

import '../screens/dashboard/dashboard_screen.dart';

class RoutePaths {
  static const String login = '/login';
  static const String mainscreen = '/mainscreen';
}

class RouterConfiguration {
  static final FluroRouter router = FluroRouter();

  static void setupRouter() {
    router.define(
      RoutePaths.login,
      handler: Handler(handlerFunc: (_, __) => LoginPage()),
    );

    router.define(
      RoutePaths.mainscreen,
      handler: Handler(handlerFunc: (_, __) => MainScreen()),
    );

    // Đăng ký các route khác
  }
}
