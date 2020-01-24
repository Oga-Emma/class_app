import 'dart:async';
import 'dart:math';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/department_dto.dart';
import 'package:class_app/model/school_dto.dart';
import 'package:class_app/model/user_dto.dart';
import 'package:class_app/service/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  get isSuperAdmin =>
      this._user != null &&
      (this._user.isSuperAdmin ||
          (this._user.admin.isMainAdmin &&
              this._user.admin.department == department.departmentCode &&
              this._user.admin.entryYear == department.entryYear));

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

  Future<void> logout() async {
    localStorage.clearUser();

    user = null;
    currentUser = null;
    var google = GoogleSignIn();
    if (google.currentUser != null) {
      google.signOut();
    }
    FirebaseAuth.instance.signOut();
  }
}
