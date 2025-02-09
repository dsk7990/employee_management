import 'package:employee_management/features/employee_add/bloc/employee_bloc.dart';
import 'package:employee_management/features/employee_add/ui/employee_add_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/employee_model.dart';

class EmployeeAddFeatureWidget extends StatelessWidget {
  EmployeeModel? employeeModel;
  EmployeeAddFeatureWidget({super.key, this.employeeModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
        create: (context) => EmployeeBloc(),
        child: EmployeeAddPresenter(
          employeeModel: employeeModel,
        ));
  }
}
