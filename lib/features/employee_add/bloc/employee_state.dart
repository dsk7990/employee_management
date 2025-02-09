import 'package:employee_management/features/employee_add/model/employee_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeState extends Equatable {}

enum EmployeeServiceStatus { initial, loading, success, failure }

class GetEmployeesState extends EmployeeState {
  final EmployeeServiceStatus status;
  final List<EmployeeModel>? currentEmployeeList;
  final List<EmployeeModel>? previousEmployeeList;
  final String? errorMessage;

  GetEmployeesState(
      {required this.status,
      this.currentEmployeeList,
      this.previousEmployeeList,
      this.errorMessage});

  @override
  List<Object?> get props =>
      [status, currentEmployeeList, previousEmployeeList, errorMessage];
}

class AddEmployeesState extends EmployeeState {
  final EmployeeServiceStatus status;
  final String? message;
  AddEmployeesState({required this.status, this.message});

  @override
  List<Object?> get props => [status, message];
}

class EditEmployeesState extends EmployeeState {
  final EmployeeServiceStatus status;
  final String? message;
  EditEmployeesState({required this.status, this.message});

  @override
  List<Object?> get props => [status, message];
}

class DeleteEmployeesState extends EmployeeState {
  final EmployeeServiceStatus status;
  final String? message;
  final EmployeeModel? employeeModel;
  DeleteEmployeesState(
      {required this.status, this.message, this.employeeModel});

  @override
  List<Object?> get props => [status, message, employeeModel];
}
