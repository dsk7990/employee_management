import 'package:employee_management/app_colors.dart';
import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  TextEditingController textEditingController;
  bool? readOnly;
  bool? enable;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? hintText;

  CTextField(
      {super.key,
      required this.textEditingController,
      this.readOnly,
      this.enable,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      readOnly: readOnly ?? false,
      enabled: enable ?? true,
      maxLines: 1,
      style: const TextStyle(color: AppColors.textColor),
      decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle: const TextStyle(color: AppColors.hintTextColor),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 1.0),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 1.0),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 1.0),
        ),
      ),
    );
  }
}
