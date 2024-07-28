import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.icon,
      this.widthIcon,
      this.heightIcon,
      this.colorIcon,
      required this.text,
      required this.fontSizeButton,
      required this.color,
      required this.backGroundColor,
      this.heightButton,
      required this.handleOnPressed});

  final dynamic icon;
  final double? widthIcon;
  final double? heightIcon;
  final Color? colorIcon;
  final String text;
  final double fontSizeButton;
  final Color? color;
  final Color? backGroundColor;
  final double? heightButton;
  final Function()? handleOnPressed;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: handleOnPressed,
        style: OutlinedButton.styleFrom(
            minimumSize:
                heightButton != null ? Size.fromHeight(heightButton!) : null,
            padding: EdgeInsets.zero,
            backgroundColor: backGroundColor,
            side: BorderSide.none,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon is String
                ? SvgPicture.asset(icon, width: widthIcon, height: heightIcon)
                : Icon(icon, color: colorIcon),
            const SizedBox(width: 3),
            Text(
              text,
              style: TextStyle(
                  fontSize: fontSizeButton,
                  color: color,
                  fontWeight: FontWeight.w400),
            )
          ],
        ));
  }
}
