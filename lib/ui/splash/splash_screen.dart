import 'dart:async';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/service/local_storage.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/auth/signup_screen.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/settings/initial_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
        body: FutureBuilder<AppInfoDTO>(
            initialData: appState.appInfo,
            future: localStorage.fetchAppInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.school != null &&
                    snapshot.data.department != null) {
//                  return checkAuth();
                  Future.delayed(Duration.zero, () {
                    appState.appInfo = snapshot.data;
                    Router.gotoNamed(Routes.FETCH_DATA, context,
                        clearStack: true);
                  });
                } else {
//                  print('nothing found');
                  return InitialSettingsScreen();
                }
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return InitialSettingsScreen();
              }

              return Center(child: CircularProgressIndicator());
            }));
  }

//  Widget checkUser(String userId) {
//    return FutureBuilder(
//        future: FirebaseUser,
//        builder: (context, snapshot){
//      if (snapshot.hasData) {
//        if (snapshot.data.school != null &&
//            snapshot.data.department != null) {
//          return checkAuth();
//        } else {
////                  print('nothing found');
//          return InitialSettingsScreen();
//        }
//      }
//      if (snapshot.hasError) {
//        print(snapshot.error);
//        return InitialSettingsScreen();
//      }
//
//      return Center(child: CircularProgressIndicator());
//    });
//  }
}
