import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/main_navigation_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: AppBar(
              flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(238, 238, 238, 1), // Đặt màu nền cho AppBar
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text("Account",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Account information",
                          style: TextStyle(fontSize: 16))
                    ],
                  ))
                ],
              ),
            ),
          )),
        ),
        bottomNavigationBar: const MainNavigation(pageName: "Account"),
        body: const Account(),
      ),
    );
  }
}

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const Text("Le Viet Duc",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
            ),
          ),
          const Row(
            children: [
              Icon(Icons.card_giftcard, color: Colors.blueAccent),
              SizedBox(width: 10),
              Text("12", style: TextStyle(fontSize: 19))
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.person, color: Colors.blueAccent),
              SizedBox(width: 10),
              Text("User name", style: TextStyle(fontSize: 19))
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.rocket_launch, color: Colors.blueAccent),
              SizedBox(width: 10),
              Text("Member", style: TextStyle(fontSize: 19))
            ],
          )
        ],
      ),
    );
  }
}
