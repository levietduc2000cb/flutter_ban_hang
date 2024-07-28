import 'package:flutter/material.dart';

import '../screens/account_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/home_screen.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key, this.pageName});

  final String? pageName;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8),
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, -3), // Move the shadow to the top
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 240,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: ()=>redirectProductsPage(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.home, color: pageName == "Products" ? Colors.blue : null),
                                Text("Home", style: TextStyle(fontSize: 12, color: pageName == "Products" ? Colors.blue : null))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: ()=>redirectCartPage(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.shopping_cart, color: pageName == "Cart" ? Colors.blue : null),
                                Text("Cart", style: TextStyle(fontSize: 12, color: pageName == "Cart" ? Colors.blue : null))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: ()=>redirectAccountPage(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.person, color: pageName == "Account" ? Colors.blue : null),
                                Text("Account", style: TextStyle(fontSize: 12, color: pageName == "Account" ? Colors.blue : null))
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void redirectProductsPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductsPage(),
        ));
  }

  void redirectCartPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartPage(),
        ));
  }

  void redirectAccountPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AccountPage(),
        ));
  }
}
