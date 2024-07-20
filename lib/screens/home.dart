import 'package:ban_hang/screens/cart.dart';
import 'package:ban_hang/screens/products.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin{

  late TabController _tabController;


  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 240,
              child: TabBar(
                controller: _tabController,
                indicator: const BoxDecoration(),
                labelStyle: const TextStyle(
                  color: Colors.blue
                ),
                tabs: const [
                  Row(
                    children: [Expanded(child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home),
                        Text("Home", style: TextStyle(fontSize: 12))
                      ],
                    ))],
                  ),
                  Row(
                    children: [
                      Expanded(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_cart),
                          Text("Cart", style: TextStyle(fontSize: 12))
                        ],
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person),
                          Text("Account", style: TextStyle(fontSize: 12))
                        ],
                      ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Products(),
          CartPage(),
          Text("333333333333"),

        ],
      ),
    );
  }
}