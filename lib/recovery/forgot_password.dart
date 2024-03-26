//import 'dart:math';

// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kosmicv2/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  Future<void> _resetPassword(BuildContext context) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sent successfully!'),
        ),
      );
    } catch (e) {
      print("Error: $e");
      String message = 'Error resetting password';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            message = 'Usuário não encontrado! Tente novamente mais tarde.';
            break;

          case 'too-many-request':
            message =
                'Muitas tentativas de redefinição de senha. Tente novamente mais tarde.';
            break;

          default:
            message = 'Erro Desconhecido. Tente novamente mais tarde.';
            break;
        }
      } else {
        print('Unexpected error: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/images/splash/back.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Centering the email field
              const SizedBox(height: 250),
              Center(
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.transparent,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 0.50,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                    stops: [0.0872, 0.5087, 0.9130],
                    colors: [
                      Color(0xFFE961FF),
                      Color(0xFF00E5E5),
                      Color(0xFF72A5F2),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await _resetPassword(context);
                    } on FirebaseAuthException catch (e) {
                      String message = 'Erro ao redefinir senha.';
                      switch (e.code) {
                        //tratar mensagem
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
