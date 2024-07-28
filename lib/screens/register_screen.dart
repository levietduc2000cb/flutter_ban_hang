import 'package:ban_hang/screens/register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                const Text("Register",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent)),
                const RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
