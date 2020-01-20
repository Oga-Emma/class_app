import 'dart:math';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/department_dto.dart';
import 'package:class_app/model/school_dto.dart';
import 'package:class_app/service/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  FirebaseUser _user;
  AppInfoDTO _appInfo = AppInfoDTO();
  AppStateProvider();

  DepartmentDTO get department => _appInfo.department;
  SchoolDTO get school => _appInfo.school;
  FirebaseUser get currentUser => _user;

  set appInfo(AppInfoDTO appInfo) {
    _appInfo = appInfo;

    localStorage.saveAppInfo(appInfo);
//    notifyListeners();
  }

  set currentUser(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }
}
