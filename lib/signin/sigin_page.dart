// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:kosmicv2/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> registerUser(String name, String email, String password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Handle successful registration (e.g., navigate to a different screen)
      print('Usuário cadastrado com sucesso!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha precisa ser mais forte.');
      } else if (e.code == 'email-already-in-use') {
        print('Este email já está em uso.');
      } else {
        print(e.message);
      }
    } catch (e) {
      print(e.toString());
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
                color: Colors.black.withOpacity(0.3),
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
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //
                    // campo de nome de usuario
                    const SizedBox(
                      height: 180,
                    ),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Nome de usuário',
                        filled: true,
                        fillColor: Colors.transparent,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por Favor, insira seu nome de usuário';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _name.text = value.trim();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    //
                    //campo de email
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        filled: true,
                        fillColor: Colors.transparent,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por Favor, informe um email válido';
                        }
                        const emailPattern =
                            r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$';
                        final regExp = RegExp(emailPattern);
                        if (!regExp.hasMatch(value)) {
                          return 'Formato de email inválido';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _email.text = value.trim();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    //campo de senha
                    TextFormField(
                      controller: _password,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.transparent,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'A senha precisa ter pelo menos 8 caracteres';
                        }
                        if (value.trim().length < 8) {
                          return 'A senha precisa ter pelo menos 8 caracteres';
                        }
                        // Você pode adicionar aqui verificações para complexidade da senha (maiúsculas, minúsculas, números, símbolos)
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _password.text = value.trim();
                        }
                      },
                    ),
                    //botaõ de cadastro
                    const SizedBox(height: 20.0),
                    Container(
                      width: 279,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              registerUser(
                                  _name.text, _email.text, _password.text);
                            }
                          },
                          child: const Text(
                            'Cadastrar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
