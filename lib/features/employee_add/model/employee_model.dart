import 'package:hive/hive.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? empName;
  @HiveField(2)
  String? empRole;
  @HiveField(3)
  String? empStartDate;
  @HiveField(4)
  String? empEndDate;
  @HiveField(5)
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
