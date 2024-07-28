import 'package:ban_hang/models/user_model.dart';
import 'package:flutter/material.dart';

import '../api/user_api.dart';
import '../utils/show_alert_widget.dart';
import '../widgets/input_form_widget.dart';
import 'login_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
  final registerFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: registerFormKey,
            child: Column(
              children: [
                InputForm(
                    keyboardType: TextInputType.text,
                    controller: fullNameController,
                    textInputAction: TextInputAction.next,
                    labelText: 'Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    }),
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
                  obscureText: passwordVisible,
                  textInputAction: TextInputAction.next,
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                InputForm(
                    keyboardType: TextInputType.text,
                    obscureText: confirmPasswordVisible,
                    controller: confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    labelText: 'Confirm password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        confirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        setState(() {
                          confirmPasswordVisible = !confirmPasswordVisible;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your confirm password';
                      } else if (value != passwordController.text) {
                        return 'Confirm password is not valid password';
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
                              onPressed: register,
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you already have an account!',
                      style: TextStyle(color: Colors.black87),
                    ),
                    TextButton(
                        onPressed: goLoginPage,
                        child: const Text(
                          'Login now',
                          style: TextStyle(color: Colors.blueAccent),
                        ))
                  ],
                )
              ],
            )));
  }

  void goLoginPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(-1.5, 0.0);
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

  Future<dynamic> register() async {
    if (registerFormKey.currentState!.validate()) {
      final userApi = UserApi();
      UserModel userRegister = UserModel(
          name: fullNameController.text,
          userName: userNameController.text,
          password: passwordController.text);
      try {
        await userApi.register(userRegister);
        if (!mounted) return;
        showAlert(context, "Thành công", "Tạo tài khoản thành công!!!",
            "Đồng ý", goLoginPage);
      } catch (err) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Register failure!!!')),
        );
      }
    }
  }
}
