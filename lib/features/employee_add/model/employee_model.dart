class EmployeeModel {
  int? id;
  String? empName;
  String? empRole;
  String? empStartDate;
  String? empEndDate;
  String? empDeleteStatus;

  EmployeeModel(
    this.empName,
    this.empRole,
    this.empStartDate,
    this.empEndDate,
    this.empDeleteStatus, {
    this.id,
  });

  EmployeeModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    empName = map['empName'];
    empRole = map['empRole'];
    empStartDate = map['empStartDate'];
    empEndDate = map['empEndDate'];
    empDeleteStatus = map['empDeleteStatus'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'empName': empName,
      'empRole': empRole,
      'empStartDate': empStartDate,
      'empEndDate': empEndDate,
      'empDeleteStatus': empDeleteStatus
    };
  }
}
