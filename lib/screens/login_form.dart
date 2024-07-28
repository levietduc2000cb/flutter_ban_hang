import 'package:ban_hang/screens/home_screen.dart';
import 'package:ban_hang/screens/register_screen.dart';
import 'package:ban_hang/utils/constant.dart';
import 'package:flutter/material.dart';

import '../api/user_api.dart';
import '../utils/local_storage.dart';
import '../widgets/input_form_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                InputForm(
                    keyboardType: TextInputType.text,
                    controller: userNameController,
                    textInputAction: TextInputAction.next,
                    labelText: 'User name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your user name';
                      }
                      return null;
                    }),
                InputForm(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    labelText: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6))),
                              onPressed: login,
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6))),
                              onPressed: () {},
                              child: const Text(
                                'Google',
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do not have an account?',
                      style: TextStyle(color: Colors.black87),
                    ),
                    TextButton(
                        onPressed: goToRegisterPage,
                        child: const Text(
                          'Register now',
                          style: TextStyle(color: Colors.blueAccent),
                        ))
                  ],
                )
              ],
            )));
  }

  void goToRegisterPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const RegisterPage(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.5, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  Future<dynamic> login() async {
    if (loginFormKey.currentState!.validate()) {
      final userApi = UserApi();
      try {
        dynamic token = await userApi.login(
            userNameController.text, passwordController.text);
        if (token.isNotEmpty) {
          await LocalStorage.setValue(Constants.token, token as String);
          if (!mounted) return;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProductsPage()));
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('User name or password is incorrect!!!')),
          );
        }
      } catch (err) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failure')),
        );
      }
    }
  }
}
