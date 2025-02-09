import 'package:employee_management/app_strings.dart';
import 'package:employee_management/custom_widgets/ctext.dart';
import 'package:flutter/material.dart';

class SelectRoleBottomSheet extends StatelessWidget {
  Function(String) onRolePressed;

  SelectRoleBottomSheet({super.key, required this.onRolePressed});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: AppStrings.roleList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            onRolePressed(AppStrings.roleList[index]);
          },
          contentPadding: EdgeInsets.zero,
          title: Center(
            child: CText(
              data: AppStrings.roleList[index],
              textColor: Colors.black,
              fontSize: 16,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
