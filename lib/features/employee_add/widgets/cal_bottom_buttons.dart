import 'package:employee_management/app_colors.dart';
import 'package:employee_management/app_images.dart';
import 'package:employee_management/custom_widgets/ctext.dart';
import 'package:flutter/material.dart';

import '../../../app_strings.dart';
import '../../../custom_widgets/cbutton.dart';

class CalBottomButtons extends StatelessWidget {
  Function() onSavePressed;
  Function() onCancelPressed;
  String date;
  CalBottomButtons(
      {super.key,
      required this.onSavePressed,
      required this.onCancelPressed,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(AppImages.eventPath),
              const SizedBox(
                width: 4,
              ),
              CText(
                data: date,
                textColor: AppColors.textColor,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CButton(
                buttonLabel: AppStrings.cancel,
                textColor: AppColors.blueColor,
                backgroundColor: Colors.blue.shade50,
                onPressed: onCancelPressed,
              ),
              const SizedBox(
                width: 16,
              ),
              CButton(
                buttonLabel: AppStrings.save,
                onPressed: onSavePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
