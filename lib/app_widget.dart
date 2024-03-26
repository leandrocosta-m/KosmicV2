import 'package:flutter/material.dart';
import 'package:kosmicv2/recovery/forgot_password.dart';
import 'package:kosmicv2/splash_page.dart';
import 'package:kosmicv2/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        //Adicionar rotas dentro do app
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/login_pass': (context) => const ForgotPasswordPage(),
        //'home' : (context) =>
      },
    );
  }
}
