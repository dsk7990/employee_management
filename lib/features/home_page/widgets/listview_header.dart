import 'package:employee_management/features/employee_add/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../app_colors.dart';
import '../../../app_strings.dart';
import '../../../custom_widgets/ctext.dart';

class ListviewHeader extends StatelessWidget {
  List<EmployeeModel> employeeList;
  Function(EmployeeModel) onDeletePressed;
  Function(EmployeeModel) onItemPressed;
  String header;
  ListviewHeader(
      {super.key,
      required this.employeeList,
      required this.onDeletePressed,
      required this.onItemPressed,
      required this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CText(
            data: header,
            textColor: AppColors.blueColor,
            fontSize: 16,
          ),
        ),
        ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: 0.5,
              color: Colors.grey.shade200,
            );
          },
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.22,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        onDeletePressed(employeeList[index]);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: AppStrings.delete,
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      onTap: () {
                        onItemPressed(employeeList[index]);
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            data: employeeList[index].empName ?? '',
                            textColor: AppColors.textColor,
                            fontSize: 16,
                          ),
                          CText(
                            data: employeeList[index].empRole ?? '',
                            textColor: AppColors.lightTextColor,
                            fontSize: 14,
                          ),
                          CText(
                            data: (employeeList[index].empEndDate?.isEmpty ??
                                    false)
                                ? '${AppStrings.from} ${employeeList[index].empStartDate}'
                                : '${employeeList[index].empStartDate} - ${employeeList[index].empEndDate}',
                            textColor: AppColors.lightTextColor,
                            fontSize: 12,
                          ),
                        ],
                      )),
                ));
          },
          itemCount: employeeList.length,
          shrinkWrap: true,
        )
      ],
    );
  }
}
