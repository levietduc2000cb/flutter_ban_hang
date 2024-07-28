import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(""),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset("images/logo/logo_truyenviet.png",
                    width: 220, height: 220),
                const Text("Login",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent)),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
