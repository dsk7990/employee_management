import 'package:employee_management/app_strings.dart';
import 'package:employee_management/features/employee_add/model/employee_model.dart';
import 'package:employee_management/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';

import 'app_colors.dart';
import 'router_generator.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeModelAdapter());
  await DatabaseHelper.instance.database;
  runApp(MyApp());
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      title: AppStrings.appName,
      routerConfig: RouteGenerate.router,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueColor),
        useMaterial3: true,
      ),
    );
  }
}
