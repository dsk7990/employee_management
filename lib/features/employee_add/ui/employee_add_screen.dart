import 'package:employee_management/app_images.dart';
import 'package:employee_management/app_strings.dart';
import 'package:employee_management/custom_widgets/ctextfield.dart';
import 'package:employee_management/features/employee_add/widgets/bottom_buttons.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../custom_widgets/ctext.dart';

class EmployeeAddScreen extends StatelessWidget {
  Function() onSavePressed;
  Function() onCancelPressed;
  Function() onSelectRolePressed;
  Function() onFromDatePressed;
  Function() onToDatePressed;
  Function() onDeletePressed;
  final TextEditingController empNameController;
  final TextEditingController selectRoleController;
  final TextEditingController fromDateController;
  final TextEditingController toDateController;
  final bool? isFromEdit;

  EmployeeAddScreen(
      {super.key,
      required this.onSavePressed,
      required this.onCancelPressed,
      required this.empNameController,
      required this.selectRoleController,
      required this.fromDateController,
      required this.toDateController,
      required this.onSelectRolePressed,
      required this.onFromDatePressed,
      required this.onToDatePressed,
      required this.onDeletePressed,
      this.isFromEdit = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.blueColor,
        title: CText(
          data: (isFromEdit ?? false)
              ? AppStrings.editEmployee
              : AppStrings.addEmployee,
          fontSize: 18,
        ),
        actions: [
          if (isFromEdit ?? false)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                  onTap: onDeletePressed,
                  child: Image.asset(AppImages.deletePath)),
            )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CTextField(
                      textEditingController: empNameController,
                      prefixIcon: Image.asset(AppImages.personPath),
                      hintText: AppStrings.hintEmployeeName),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: onSelectRolePressed,
                    child: CTextField(
                      textEditingController: selectRoleController,
                      hintText: AppStrings.hintSelectRole,
                      enable: false,
                      prefixIcon: Image.asset(AppImages.workPath),
                      suffixIcon: Image.asset(AppImages.arrowDownPath),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: GestureDetector(
                          onTap: onFromDatePressed,
                          child: CTextField(
                            textEditingController: fromDateController,
                            hintText: AppStrings.hintNoDate,
                            enable: false,
                            prefixIcon: Image.asset(AppImages.eventPath),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                              height: 30,
                              child: Image.asset(AppImages.arrowRightPath))),
                      Expanded(
                        flex: 4,
                        child: GestureDetector(
                          onTap: onToDatePressed,
                          child: CTextField(
                            textEditingController: toDateController,
                            hintText: AppStrings.hintNoDate,
                            enable: false,
                            prefixIcon: Image.asset(AppImages.eventPath),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Divider(),
            BottomButtons(
              onSavePressed: onSavePressed,
              onCancelPressed: onCancelPressed,
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
