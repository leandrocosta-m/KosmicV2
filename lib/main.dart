import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kosmicv2/splash_page.dart';

//configuração do App encontrada no FirebaseOptions
const FirebaseOptions kFirebaseOptions = FirebaseOptions(
  apiKey: 'AIzaSyDyhDEGzk3jyCRJ6BO5NyD32fjZYZGQVnE',
  appId: '1:38097637181:android:821368466b70b295beff54',
  messagingSenderId: '38097637181',
  projectId: 'conectfirebase-c44f8',
  storageBucket: 'conectfirebase-c44f8.appspot.com',
);

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter widgets are initialized

  // Initialize Firebase only once
  await Firebase.initializeApp(options: kFirebaseOptions);

  runApp(const MyApp()); // Run your app after Firebase is initialized
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
