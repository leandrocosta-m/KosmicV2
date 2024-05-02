// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kosmicv2/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  bool _nameError = false;
  bool _emailError = false;
  bool _passwordError = false;

  //configuração do campo de nome de usuario
  void showErrorName() {
    setState(() {
      _nameError = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _nameError = false;
      });
    });
  }

  //configuraçã do campo de email
  void showErrorEmail() {
    setState(() {
      _emailError = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _emailError = false;
      });
    });
  }

  //Configuração do campo de senha
  void showErrorpassword() {
    setState(() {
      _passwordError = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _passwordError = false;
      });
    });
  }

  Future<void> registerUser(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await saveUserData(userCredential.user!.uid, name, email, password);

      await userCredential.user!.sendEmailVerification();

      //exibir um snackbar se o informando o usuario a verificar o email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verifique seu e-mail para confirmar o cadastro'),
          duration: Duration(seconds: 2), //define a duração do SnackBar
        ),
      );

      // Handle successful registration (e.g., navigate to a different screen)
      print('Usuário cadastrado com sucesso!, verifique seu email');
      Navigator.pop(context); //retorna para a tela de login
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

  Future<void> saveUserData(
    String userId,
    String name,
    String email,
    String password,
  ) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(userId).set({
        'name': name,
        'email': email,
        'password': password,
      });
    } catch (e) {
      print('Erro ao salvar os dados');
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
        width: double
            .infinity, // Define a largura do container como a largura total da tela
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/images/splash/back.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 200,
              height: 440,
              width: 360,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //
                    //logo
                    SizedBox(height: 50),
                    Image.asset(
                      width: 100,
                      height: 100,
                      'lib/assets/images/splash/logo.png',
                    ),
                    // campo de nome de usuario
                    const SizedBox(
                      height: 80,
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
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: _nameError
                                ? Color(0xff920f06)
                                : Colors.deepPurple,
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
                        errorStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          showErrorName();
                          //return 'Por Favor, insira seu nome de usuário';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _name.text = value.trim();
                        }
                      },
                    ),
                    const SizedBox(height: 6),
                    if (_nameError)
                      const Text(
                        'Por Favor, insira seu nome de usuário',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
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
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: _emailError
                                ? Color(0xff920f06)
                                : Colors.deepPurple,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          showErrorEmail();
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
                    const SizedBox(height: 6),
                    if (_emailError)
                      const Text(
                        'Por favor informe um email válido!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
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
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: _passwordError
                                ? Color(0xff920f06)
                                : Colors.deepPurple,
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
                        errorStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          showErrorpassword();
                          return 'Por favor, informe uma senha valida!';
                        }
                        if (value.trim().length < 8) {
                          showErrorpassword();
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
                    const SizedBox(height: 6),
                    if (_passwordError)
                      const Text(
                        'Por Favor, insira seu nome de usuário',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
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
                                context,
                                _name.text,
                                _email.text,
                                _password.text,
                              );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
