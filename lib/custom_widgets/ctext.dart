import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  String data;
  Color? textColor;
  double? fontSize;

  CText({super.key, required this.data, this.textColor, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: textColor ?? Colors.white,
        fontSize: fontSize ?? 14,
      ),
    );
  }
}
