import 'dart:math';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/department_dto.dart';
import 'package:class_app/model/school_dto.dart';
import 'package:class_app/model/user_dto.dart';
import 'package:class_app/service/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  UserDTO _user;
  FirebaseUser _currentuser;
  AppInfoDTO _appInfo = AppInfoDTO();
  AppStateProvider();

  AppInfoDTO get appInfo => _appInfo;
  DepartmentDTO get department => _appInfo.department;
  SchoolDTO get school => _appInfo.school;
  FirebaseUser get currentUser => _currentuser;
  UserDTO get user => _user;

  set appInfo(AppInfoDTO appInfo) {
    _appInfo = appInfo;

    localStorage.saveAppInfo(appInfo);
//    notifyListeners();
  }

  set currentUser(FirebaseUser user) {
    _currentuser = user;
    notifyListeners();
  }

  set user(UserDTO user) {
    _user = user;
    notifyListeners();
  }
}
