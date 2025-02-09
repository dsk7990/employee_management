import 'package:employee_management/features/employee_add/model/employee_model.dart';
import 'package:employee_management/features/home_page/ui/homepage_feature_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/employee_add/ui/employee_add_feature_widget.dart';

class RouteGenerate {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomepageFeatureWidget();
        },
      ),
      GoRoute(
        path: '/add',
        builder: (BuildContext context, GoRouterState state) {
          return EmployeeAddFeatureWidget(
            employeeModel:
                state.extra != null ? state.extra as EmployeeModel : null,
          );
        },
      ),
    ],
  );
}
