import 'package:employee_management/app_strings.dart';
import 'package:employee_management/custom_widgets/csnackbar.dart';
import 'package:employee_management/features/employee_add/bloc/employee_bloc.dart';
import 'package:employee_management/features/employee_add/bloc/employee_event.dart';
import 'package:employee_management/features/employee_add/bloc/employee_state.dart';
import 'package:employee_management/features/employee_add/ui/employee_add_screen.dart';
import 'package:employee_management/features/employee_add/widgets/cal_end_date.dart';
import 'package:employee_management/features/employee_add/widgets/select_role_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../model/employee_model.dart';
import '../widgets/cal_start_date.dart';

class EmployeeAddPresenter extends StatelessWidget {
  EmployeeModel? employeeModel;
  EmployeeAddPresenter({super.key, this.employeeModel});
  final TextEditingController _empNameController = TextEditingController();
  final TextEditingController _selectRoleController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  clearData() {
    _empNameController.text = '';
    _selectRoleController.text = '';
    _fromDateController.text = '';
    _toDateController.text = '';
  }

  setData() {
    if (employeeModel != null) {
      _empNameController.text = employeeModel?.empName ?? '';
      _selectRoleController.text = employeeModel?.empRole ?? '';
      _fromDateController.text = employeeModel?.empStartDate ?? '';
      _toDateController.text = employeeModel?.empEndDate ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    setData();
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) async {
        if (state is AddEmployeesState) {
          if (state.status == EmployeeServiceStatus.initial ||
              state.status == EmployeeServiceStatus.loading) {
            EasyLoading.show(status: AppStrings.progressMsg);
          } else if (state.status == EmployeeServiceStatus.success) {
            EasyLoading.dismiss();
            CSnackBar().showSnackBar(
              state.message ?? '',
            );
            clearData();
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
            CSnackBar().showSnackBar(
              state.message ?? '',
            );
            clearData();
          } else if (state.status == EmployeeServiceStatus.failure) {
            EasyLoading.dismiss();
            CSnackBar().showSnackBar(
              state.message ?? '',
            );
          }
        } else if (state is DeleteEmployeesState) {
          if (state.status == EmployeeServiceStatus.initial ||
              state.status == EmployeeServiceStatus.loading) {
            EasyLoading.show(status: AppStrings.progressMsg);
          } else if (state.status == EmployeeServiceStatus.success) {
            EasyLoading.dismiss();
            context.pop(true);

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
        }
      },
      child: EmployeeAddScreen(
        empNameController: _empNameController,
        selectRoleController: _selectRoleController,
        fromDateController: _fromDateController,
        toDateController: _toDateController,
        isFromEdit: employeeModel != null,
        onDeletePressed: () {
          // context.read<EmployeeBloc>().add(DeleteEmployeeEvent(
          //     id: employeeModel?.id,
          //     empName: employeeModel?.empName,
          //     empRole: employeeModel?.empRole,
          //     empStartDate: employeeModel?.empStartDate,
          //     empEndDate: employeeModel?.empEndDate));
          context.pop(true);
        },
        onSelectRolePressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SelectRoleBottomSheet(
                onRolePressed: (value) {
                  _selectRoleController.text = value;
                  context.pop();
                },
              );
            },
          );
        },
        onFromDatePressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: CalStartDate(
                    onSavePressed: (selectedDate) {
                      context.pop();
                      _fromDateController.text =
                          selectedDate.isNotEmpty ? selectedDate : '';
                    },
                    onCancelPressed: () {
                      context.pop();
                    },
                  )));
        },
        onToDatePressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: CalEndDate(
                    onSavePressed: (selectedDate) {
                      context.pop();
                      _toDateController.text =
                          selectedDate.isNotEmpty ? selectedDate : '';
                    },
                    onCancelPressed: () {
                      context.pop();
                    },
                  )));
        },
        onSavePressed: () {
          if (_empNameController.text.isEmpty) {
            CSnackBar().showSnackBar(AppStrings.enterEmpNameMsg);
          } else if (_selectRoleController.text.isEmpty) {
            CSnackBar().showSnackBar(AppStrings.selectEmpRoleMsg);
          } else if (_fromDateController.text.isEmpty) {
            CSnackBar().showSnackBar(AppStrings.selectStartDateMsg);
          } else {
            if (_toDateController.text.isNotEmpty) {
              DateFormat dateFormat = DateFormat('dd MMM, yyyy');
              DateTime dateStart = dateFormat.parse(_fromDateController.text);
              DateTime dateEnd = dateFormat.parse(_toDateController.text);
              bool isValidDate = dateStart.isBefore(dateEnd);
              if (!isValidDate) {
                CSnackBar().showSnackBar(AppStrings.endDateValidationMsg);
                return;
              }
            }

            if (employeeModel != null) {
              context.read<EmployeeBloc>().add(EditEmployeeEvent(
                  id: employeeModel?.id,
                  empName: _empNameController.text,
                  empRole: _selectRoleController.text,
                  empStartDate: _fromDateController.text,
                  empEndDate: _toDateController.text));
            } else {
              context.read<EmployeeBloc>().add(AddEmployeeEvent(
                  empName: _empNameController.text,
                  empRole: _selectRoleController.text,
                  empStartDate: _fromDateController.text.isNotEmpty
                      ? _fromDateController.text
                      : '',
                  empEndDate: _toDateController.text.isNotEmpty
                      ? _toDateController.text
                      : ''));
            }
          }
        },
        onCancelPressed: () {
          context.pop();
        },
      ),
    );
  }
}
