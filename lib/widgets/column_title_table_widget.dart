import 'package:flutter/material.dart';

class ColumnTitleTable extends StatelessWidget {
  const ColumnTitleTable({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(249, 249, 249, 1),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          child: Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
    );
  }
}
