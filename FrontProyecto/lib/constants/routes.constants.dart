import 'package:flutter/cupertino.dart';
import 'package:sava_mobile/screens/screens.dart';

class PagesRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "login": (_) => LoginScreen()
  };
}
