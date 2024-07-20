import 'package:flutter/material.dart';

class ProductDetailInfor extends StatelessWidget {
  const ProductDetailInfor({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final dynamic description;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$title:",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(left: 6),
              child: Text(description.toString(), style: const TextStyle(fontSize: 16)),
            )
          ],
        ));
  }
}
