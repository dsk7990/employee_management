import 'package:employee_management/app_strings.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'ctext.dart';

class CSnackBar {
  showSnackBar(String msg, {String? btnLabel, Function()? onActionPressed}) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: CText(data: msg),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: btnLabel ?? AppStrings.close,
        onPressed: onActionPressed ?? () {},
      ),
    ));
  }
}
