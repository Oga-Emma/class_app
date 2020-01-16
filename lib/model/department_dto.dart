class DepartmentDTO {
  String id;
  String name;
  String departmentCode;
  int currentLevel;
  int currentSemester;
  String currentSession;
  String faculty;
  String studyDuration;
  String entryYear;
  String graduationYear;

  DepartmentDTO();
  DepartmentDTO.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    departmentCode = data['departmentCode'];
    currentLevel = data['currentLevel'];
    currentSemester = data['currentSemester'];
    currentSession = data['currentSession'];
    faculty = data['faculty'];
    studyDuration = data['studyDuration'];
    entryYear = data['entryYear'];
    graduationYear = data['graduationYear'];
  }
}
