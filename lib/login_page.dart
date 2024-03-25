import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String email = 'admin';
  String senha = '123';
  double forgotPasswordOffset = 10.0;

  Future<void> _handleLogin() async {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    email = emailController.text;
    final String password = passwordController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user!.uid.isNotEmpty) {
        //adicionar mensagem de tratativa de Login Successful
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message?.toString() ?? 'Unknown eror'),
        ),
      );
    }
  }

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'lib/assets/images/splash/logo.png',
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          //camada transparente
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
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          email = text;
                        });
                      },
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
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          senha = text;
                        });
                      },
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        fillColor: Colors.transparent,
                        filled: true,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: forgotPasswordOffset,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('forgot_password');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF11DCE8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //posição do botão Login
          const Positioned(
            top: 320,
            left: 30,
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 0.1,
          ),
          Positioned(
            top: 540,
            left: 40,
            child: Container(
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
                    _handleLogin();
                    if (email == 'admin' && senha == '123') {
                      Navigator.of(context).pushReplacementNamed('/home');
                    } else {
                      //mensagem de erro de login
                    }
                  },
                  child: const Text(
                    'Login',
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
          ),
          Positioned(
            top: 540 + 44 + 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 0.1,
                  width: 70,
                  color: Colors.grey,
                ),
                const SizedBox(width: 1),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: Text(
                    'or Sign In using',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 1,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 5,
                  ),
                  height: 0.1,
                  width: 70,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          //cria um circulo preto na imagem twitter e adiciona a imagem
          Positioned(
            left: 80,
            bottom: 90,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 14.0,
                  ),
                ],
                shape: BoxShape.circle,
                color: Color(0xff111010),
              ),
              child: const Center(
                child: Image(
                  width: 40,
                  height: 40,
                  image: AssetImage(
                    'lib/assets/images/login/x.png',
                  ),
                ),
              ),
            ),
          ),
          //configuração para o facebook
          Positioned(
            left: 160,
            bottom: 90,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15.0,
                  ),
                ],
                shape: BoxShape.circle,
                color: Color(0xff111010),
              ),
              child: const Center(
                child: Image(
                  width: 50,
                  height: 50,
                  image: AssetImage(
                    'lib/assets/images/login/face.png',
                  ),
                ),
              ),
            ),
          ),
          //confriguração para o gmail
          Positioned(
            right: 80,
            bottom: 90,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15.0,
                  ),
                ],
                shape: BoxShape.circle,
                color: Color(0xff111010),
              ),
              child: const Center(
                child: Image(
                  width: 50,
                  height: 50,
                  image: AssetImage(
                    'lib/assets/images/login/google.png',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 1,
          ),
          //texto 'dont have an account'
          Positioned(
            left: 80,
            bottom: 40,
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: 'Sign In',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF11DCE8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height + 140,
          child: _body(),
        ),
      ),
    );
  }
}
