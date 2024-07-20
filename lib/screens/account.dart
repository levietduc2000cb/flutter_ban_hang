import 'package:flutter/material.dart';

import '../widgets/main_navigation.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        bottomNavigationBar: MainNavigation(pageName: "Account"),
        body: Center(
          child: Text("Account Page!!!")
        )
      ),
    );
  }
}

