import 'package:employee_management/app_colors.dart';
import 'package:employee_management/app_images.dart';
import 'package:employee_management/features/employee_add/model/employee_model.dart';
import 'package:employee_management/features/home_page/widgets/listview_header.dart';
import 'package:flutter/material.dart';

import '../../../app_strings.dart';
import '../../../custom_widgets/ctext.dart';

class HomepageScreen extends StatelessWidget {
  Function() onAddPressed;
  Function(EmployeeModel) onDeletePressed;
  Function(EmployeeModel) onItemPressed;
  List<EmployeeModel> currentEmployeeList;
  List<EmployeeModel> previousEmployeeList;

  HomepageScreen(
      {super.key,
      required this.onAddPressed,
      required this.currentEmployeeList,
      required this.previousEmployeeList,
      required this.onDeletePressed,
      required this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.blueColor,
        title: CText(
          data: AppStrings.employeeList,
          fontSize: 18,
        ),
      ),
      body: (currentEmployeeList.isNotEmpty || previousEmployeeList.isNotEmpty)
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(currentEmployeeList.isNotEmpty)
                  Flexible(
                      child: ListviewHeader(
                          header: AppStrings.currentEmployees,
                          employeeList: currentEmployeeList,
                          onDeletePressed: onDeletePressed,
                          onItemPressed: onItemPressed)),
                  if(previousEmployeeList.isNotEmpty)
                    Flexible(
                        child: ListviewHeader(
                            header: AppStrings.previousEmployees,
                            employeeList: previousEmployeeList,
                            onDeletePressed: onDeletePressed,
                            onItemPressed: onItemPressed)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CText(
                      data: AppStrings.swipeLeft,
                      textColor: AppColors.lightTextColor,
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Image.asset(AppImages.noEmpPath),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPressed,
        backgroundColor: AppColors.blueColor,
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
