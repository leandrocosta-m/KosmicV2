import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {
  bool _firebaseInitialized = false;
  /*
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, '/login');
    });
  }*/

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _firebaseInitialized = true;
      });
    } catch (error) {
      print("Firebase initialization error: $error");
    }
  }

  //verifica a conexao com o firebase
  @override
  Widget build(BuildContext context) {
    if (!_firebaseInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text("Splash Screen")),
        body: const Center(child: Text('teste')),
      );
    } else {
      // Após o Firebase ser inicializado, você pode navegar para a próxima tela aqui.
      // Neste exemplo, estamos simplesmente exibindo um texto.
      /*return Scaffold(
        appBar: AppBar(title: const Text("Splash Screen")),
        body: const Center(
          child: Text('Firebase initialized!'),
        ),
      );*/
      return Scaffold(
        body: GestureDetector(
          onTap: () {
            //Navigator.pushReplacementNamed(context, '/');
          },
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'lib/assets/images/splash/back.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 290,
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/images/splash/Ellipse.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/images/splash/logo.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
