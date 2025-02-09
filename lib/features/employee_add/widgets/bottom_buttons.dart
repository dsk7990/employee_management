import 'package:employee_management/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../app_strings.dart';
import '../../../custom_widgets/cbutton.dart';

class BottomButtons extends StatelessWidget {
  Function() onSavePressed;
  Function() onCancelPressed;
  BottomButtons(
      {super.key, required this.onSavePressed, required this.onCancelPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
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
    );
  }
}
