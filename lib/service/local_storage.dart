import 'dart:async';
import 'dart:convert';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences pref;

  saveAppInfo(AppInfoDTO appInfo) async {
    //cache to local storage
    pref = await SharedPreferences.getInstance();
    pref.setString('app-info', json.encode(appInfo.toMap()));
  }

  Future<AppInfoDTO> fetchAppInfo() async {
    //cache to local storage
    pref = await SharedPreferences.getInstance();
    var data = pref.getString('app-info');

//    print(data);
    AppInfoDTO appInfo;
    if (data != null &&
        data.isNotEmpty &&
        data.contains('school') &&
        data.contains('department')) {
      appInfo = AppInfoDTO.fromMap(json.decode(data));
    }

    if (appInfo == null) {
      throw Exception('no data found');
    }
    return appInfo;
  }

  updateFirstTime(bool firstTime) {
    //cache to local storage
  }

  Future<bool> getFirstTime() async {}

  saveUser(UserDTO user) async {
    //cache to local storage
    //cache to local storage
    pref = await SharedPreferences.getInstance();
    pref.setString('user-info', json.encode(user.toMap()));
  }

  clearUser() async {
    //cache to local storage
    pref = await SharedPreferences.getInstance();
    pref.setString('user-info', '');
  }

  Future<UserDTO> getUser() async {
    //cache to local storage
    pref = await SharedPreferences.getInstance();
    var data = pref.getString('user-info');

    UserDTO user = UserDTO();
    if (data != null && data.isNotEmpty) {
      user = UserDTO.fromMap(json.decode(data));
    }

    return user;
  }
}

final localStorage = LocalStorage();
