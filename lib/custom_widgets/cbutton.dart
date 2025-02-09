import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'ctext.dart';

class CButton extends StatelessWidget {
  String buttonLabel;
  Function() onPressed;
  Color? backgroundColor;
  Color? textColor;
  CButton(
      {super.key,
      required this.buttonLabel,
      required this.onPressed,
      this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ??
              AppColors.blueColor, // set the background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
        ),
        onPressed: onPressed,
        child: CText(
          data: buttonLabel,
          textColor: textColor,
        ));
  }
}
