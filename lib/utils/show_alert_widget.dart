import 'package:flutter/material.dart';

void showAlert(BuildContext context, String title, String des,
    String textButton, Function() handleOnPress, {bool? isHaveCancelButton}) {

  isHaveCancelButton = isHaveCancelButton ?? false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(des),
        actions: isHaveCancelButton! ? [
          TextButton(
            onPressed: () {
              handleOnPress();
            },
            child: const Text("Đóng"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              handleOnPress();
            },
            child: Text(textButton),
          )
        ] : [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              handleOnPress();
            },
            child: Text(textButton),
          )
        ],
      );
    },
  );
}
