import 'package:employee_management/app_strings.dart';
import 'package:employee_management/features/employee_add/bloc/employee_event.dart';
import 'package:employee_management/features/employee_add/bloc/employee_state.dart';
import 'package:employee_management/features/employee_add/model/employee_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../services/database_helper.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc()
      : super(GetEmployeesState(status: EmployeeServiceStatus.initial)) {

    on<AddEmployeeEvent>((event, emit) => addEmployee(event, emit, state));
    on<EditEmployeeEvent>((event, emit) => editEmployee(event, emit, state));
    on<DeleteEmployeeEvent>(
        (event, emit) => deleteEmployee(event, emit, state));
    on<GetEmployeesEvent>((event, emit) => getEmployees(event, emit, state));
  }

  DatabaseHelper employeeDatabase = DatabaseHelper.instance;
  Future addEmployee(
      event, Emitter<EmployeeState> emit, EmployeeState state) async {
    emit(AddEmployeesState(status: EmployeeServiceStatus.loading));
    try {
      EmployeeModel model = EmployeeModel(event.empName, event.empRole,
          event.empStartDate, event.empEndDate, '0');
      await employeeDatabase.insert(model);
      emit(AddEmployeesState(
          status: EmployeeServiceStatus.success,
          message: AppStrings.empAddedMsg));
    } catch (e) {
      emit(AddEmployeesState(
          status: EmployeeServiceStatus.failure,
          message: AppStrings.empAddedFailedMsg));
    }
  }

  Future editEmployee(
      event, Emitter<EmployeeState> emit, EmployeeState state) async {
    emit(EditEmployeesState(status: EmployeeServiceStatus.loading));
    try {
      EmployeeModel model = EmployeeModel(
        event.empName,
        event.empRole,
        event.empStartDate,
        event.empEndDate,
        '0',
        id: event.id,
      );
      await employeeDatabase.update(model);
      emit(EditEmployeesState(
          status: EmployeeServiceStatus.success,
          message: AppStrings.empUpdatedMsg));
    } catch (e) {
      emit(EditEmployeesState(
          status: EmployeeServiceStatus.failure,
          message: AppStrings.empUpdatedFailedMsg));
    }
  }

  Future deleteEmployee(
      event, Emitter<EmployeeState> emit, EmployeeState state) async {
    emit(DeleteEmployeesState(status: EmployeeServiceStatus.loading));
    try {
      EmployeeModel model = EmployeeModel(
        event.empName,
        event.empRole,
        event.empStartDate,
        event.empEndDate,
        '1',
        id: event.id,
      );
      await employeeDatabase.update(model); // Soft delete
      emit(DeleteEmployeesState(
          status: EmployeeServiceStatus.success,
          employeeModel: model,
          message: AppStrings.empDeletedMsg));
    } catch (e) {
      emit(DeleteEmployeesState(
          status: EmployeeServiceStatus.failure,
          message: AppStrings.empDeletedFailedMsg));
    }
  }

  Future getEmployees(
      event, Emitter<EmployeeState> emit, EmployeeState state) async {
    emit(GetEmployeesState(status: EmployeeServiceStatus.loading));
    try {
      List<EmployeeModel> list = await employeeDatabase.getAllExceptDeleted();
      List<EmployeeModel> currentEmployee = [];
      List<EmployeeModel> previousEmployee = [];
      for (final element in list) {
        if (element.empEndDate?.isNotEmpty ?? false) {
          previousEmployee.add(element);
        } else {
          currentEmployee.add(element);
        }
      }
      DateFormat format = DateFormat("dd MMM, YYYY");
      previousEmployee.sort((a, b) {
        return ((b.empStartDate ?? '')).compareTo((a.empStartDate ?? ''));
      });
      emit(GetEmployeesState(
          status: EmployeeServiceStatus.success,
          currentEmployeeList: currentEmployee,
          previousEmployeeList: previousEmployee));
    } catch (e) {
      emit(GetEmployeesState(
          status: EmployeeServiceStatus.failure,
          errorMessage: AppStrings.noEmployee));
    }
  }
}
