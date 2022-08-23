import 'package:flutter/material.dart';
import 'package:sava_mobile/screens/screens.dart';

void main() {
  runApp(const SavaExpressApp());
}

class SavaExpressApp extends StatelessWidget {
  const SavaExpressApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SavaExpress',
      initialRoute: "login",
      routes: {
        "login": (_) => const LoginScreen(),
        "registration": (_) => const RegistrationScreen(),
        "home_client": (_) => const HomeClientScreen(),
        "historial_client": (_) => const HistorialClientScreen()
      },
    );
  }
}
