import 'package:class_app/model/department_dto.dart';
import 'package:class_app/model/school_dto.dart';

class AppInfoDTO {
  SchoolDTO school;
  DepartmentDTO department;

  AppInfoDTO();
  AppInfoDTO.fromMap(Map<String, dynamic> data) {
    school = SchoolDTO.fromMap(data['school'] ?? {});
    department = DepartmentDTO.fromMap(data['department'] ?? {});
  }

  Map<String, dynamic> toMap() {
    return {'school': school.toMap(), "department": department.toMap()};
  }
}
