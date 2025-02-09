abstract class EmployeeEvent {}

class GetEmployeesEvent extends EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  String? empName;
  String? empRole;
  String? empStartDate;
  String? empEndDate;
  AddEmployeeEvent(
      {this.empName, this.empRole, this.empStartDate, this.empEndDate});
}

class EditEmployeeEvent extends EmployeeEvent {
  int? id;
  String? empName;
  String? empRole;
  String? empStartDate;
  String? empEndDate;
  EditEmployeeEvent(
      {this.id,
      this.empName,
      this.empRole,
      this.empStartDate,
      this.empEndDate});
}

class DeleteEmployeeEvent extends EmployeeEvent {
  int? id;
  String? empName;
  String? empRole;
  String? empStartDate;
  String? empEndDate;

  DeleteEmployeeEvent(
      {this.id,
      this.empName,
      this.empRole,
      this.empStartDate,
      this.empEndDate});
}
