// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kosmicv2/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  Color _emailBorderColor = Colors.deepPurple;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _resetPassword(BuildContext context) async {
    print('Iniciando resetPassword');
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      print('email vazio alterando a cor para red');

      Future.delayed(const Duration(seconds: 3));

      setState(() {
        _emailBorderColor = Colors.deepPurple;
      });

      setState(() {
        _emailBorderColor = Colors.red;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          content: Text('Por favor, informe um email válido!'),
        ),
      );

      return;
    }

    try {
      print('Email não está vazio, tentando redefinir senha');
      final auth = FirebaseAuth.instance;

      // Verificar se o email está registrado
      final signInMethods = await auth.fetchSignInMethodsForEmail(email);
      print('Métodos de login obtidos: $signInMethods');

      if (signInMethods.contains('password')) {
        await auth.sendPasswordResetEmail(email: email);

        setState(() {
          _emailBorderColor = Colors.deepPurple;
        });
        // Se 'password' estiver entre os métodos de login, o email está registrado
        await auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.transparent,
            content: Text(
              'Email enviado!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
        print('Email enviado com sucesso');
      } else {
        // Se 'password' não estiver entre os métodos de login, o email não está registrado
        throw FirebaseAuthException(
          code: 'email-not-found',
          message: 'Usuário não encontrado! Tente novamente mais tarde.',
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'email-not-found':
          message = 'Usuário não encontrado! Tente novamente mais tarde.';
          break;
        case 'too-many-requests':
          message =
              'Muitas tentativas de redefinição de senha. Tente novamente mais tarde.';
          break;
        default:
          message = 'Erro Desconhecido. Tente novamente mais tarde.';
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      print('Erro ao redefinir senha: $message');
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Imagem de fundo
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
          Positioned.fill(
            child: Center(
              child: Image.asset(
                'lib/assets/images/splash/logo.png',
              ),
            ),
          ),
          // Camada transparente
          Positioned(
            top: 285,
            height: 495,
            width: 360,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Centralizando o campo de email
                    const SizedBox(height: 80),
                    Center(
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFocusNode,
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
                            borderSide: BorderSide(
                              //color: Colors.white,
                              color: _emailBorderColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: _emailBorderColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          } catch (e) {
                            String message = 'Erro ao redefinir senha.';
                            if (e is FirebaseAuthException) {
                              switch (e.code) {
                                case 'user-not-found':
                                  message = 'Usuário não encontrado.';
                                  break;
                                case 'invalid-email':
                                  message = 'Email inválido.';
                                  break;
                                default:
                                  message = 'Erro desconhecido.';
                              }
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
                    const SizedBox(height: 0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
