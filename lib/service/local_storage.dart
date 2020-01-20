import 'dart:async';
import 'dart:convert';

import 'package:class_app/model/app_info_dto.dart';
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

    print(data);
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
  bool getFirstTime() {
    //cache to local storage
  }
}

final localStorage = LocalStorage();
