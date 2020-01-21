import 'dart:async';
import 'dart:math';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/department_dto.dart';
import 'package:class_app/model/preference_dto.dart';
import 'package:class_app/model/school_dto.dart';
import 'package:class_app/model/user_dto.dart';
import 'package:class_app/service/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class PreferenceStateProvider extends ChangeNotifier {
  PreferenceDTO _pref;

  set appInfo(PreferenceDTO pref) {
    _pref = pref;

//    localStorage.saveAppInfo(appInfo);
//    notifyListeners();
  }
}
