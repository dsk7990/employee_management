import 'package:employee_management/features/employee_add/bloc/employee_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import '../../../app_strings.dart';
import '../../../custom_widgets/csnackbar.dart';
import '../../employee_add/bloc/employee_bloc.dart';
import '../../employee_add/bloc/employee_state.dart';
import 'homepage_screen.dart';

class HomepagePresenter extends StatelessWidget {
  const HomepagePresenter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
        bloc: context.read<EmployeeBloc>()..add(GetEmployeesEvent()),
        listener: (context, state) {
          if (state is DeleteEmployeesState) {
            if (state.status == EmployeeServiceStatus.initial ||
                state.status == EmployeeServiceStatus.loading) {
              EasyLoading.show(status: AppStrings.progressMsg);
            } else if (state.status == EmployeeServiceStatus.success) {
              EasyLoading.dismiss();
              CSnackBar().showSnackBar(
                state.message ?? '',
                btnLabel: AppStrings.undo,
                onActionPressed: () {
                  context.read<EmployeeBloc>().add(EditEmployeeEvent(
                      id: state.employeeModel?.id,
                      empName: state.employeeModel?.empName,
                      empRole: state.employeeModel?.empRole,
                      empStartDate: state.employeeModel?.empStartDate,
                      empEndDate: state.employeeModel?.empEndDate));
                },
              );
              context.read<EmployeeBloc>().add(GetEmployeesEvent());
            } else if (state.status == EmployeeServiceStatus.failure) {
              EasyLoading.dismiss();
              CSnackBar().showSnackBar(
                state.message ?? '',
              );
            }
          } else if (state is EditEmployeesState) {
            if (state.status == EmployeeServiceStatus.initial ||
                state.status == EmployeeServiceStatus.loading) {
              EasyLoading.show(status: AppStrings.progressMsg);
            } else if (state.status == EmployeeServiceStatus.success) {
              EasyLoading.dismiss();
              CSnackBar().showSnackBar(AppStrings.empRestored);
              context.read<EmployeeBloc>().add(GetEmployeesEvent());
            } else if (state.status == EmployeeServiceStatus.failure) {
              EasyLoading.dismiss();
              CSnackBar().showSnackBar(AppStrings.empRestoredFaied);
            }
          }
        },
        buildWhen: (previous, current) =>
            previous != current && current is GetEmployeesState,
        builder: (context, state) {
          if (state is GetEmployeesState) {
            if (state.status == EmployeeServiceStatus.initial ||
                state.status == EmployeeServiceStatus.loading) {
              EasyLoading.show(status: AppStrings.progressMsg);
            } else if (state.status == EmployeeServiceStatus.success) {
              EasyLoading.dismiss();
              return HomepageScreen(
                currentEmployeeList: state.currentEmployeeList ?? [],
                previousEmployeeList: state.previousEmployeeList ?? [],
                onAddPressed: () {
                  context.push('/add').then(
                    (value) {
                      context.read<EmployeeBloc>().add(GetEmployeesEvent());
                    },
                  );
                },
                onDeletePressed: (employeeModel) {
                  context.read<EmployeeBloc>().add(DeleteEmployeeEvent(
                      id: employeeModel.id,
                      empName: employeeModel.empName,
                      empRole: employeeModel.empRole,
                      empStartDate: employeeModel.empStartDate,
                      empEndDate: employeeModel.empEndDate));
                },
                onItemPressed: (employeeModel) {
                  context.push('/add', extra: employeeModel).then(
                    (value) {
                      if (value != null && value as bool) {
                        context.read<EmployeeBloc>().add(DeleteEmployeeEvent(
                            id: employeeModel.id,
                            empName: employeeModel.empName,
                            empRole: employeeModel.empRole,
                            empStartDate: employeeModel.empStartDate,
                            empEndDate: employeeModel.empEndDate));
                      }
                      context.read<EmployeeBloc>().add(GetEmployeesEvent());
                    },
                  );
                },
              );
            } else if (state.status == EmployeeServiceStatus.failure) {
              EasyLoading.dismiss();
            }
          }
          return Container();
        });
  }
}
