import 'dart:async';

import 'package:class_app/model/user_dto.dart';
import 'package:class_app/service/user_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class FetchDataScreen extends StatefulWidget {
  @override
  _FetchDataScreenState createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  bool _checkingAuth = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () => checkAuth());
    super.initState();
  }

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);

    return Scaffold(
        body: Container(
      child: _checkingAuth
          ? Center(child: CircularProgressIndicator())
          : appState.currentUser == null
              ? Center(
                  child: Text('Error fetching data, please check your network'),
                )
              : StreamBuilder<UserDTO>(
                  initialData: appState.user,
                  stream: Observable.fromFuture(
                      UserDAO.getUser(appState.currentUser.uid)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Future.delayed(Duration.zero, () {
                        appState.user = snapshot.data;
                        Router.gotoNamed(Routes.HOME, context,
                            clearStack: true);
                      });
                    }

                    if (snapshot.hasError) {
                      print(snapshot.error);

                      Future.delayed(
                          Duration.zero,
                          () => Router.gotoNamed(Routes.HOME, context,
                              clearStack: true));
//                      return Center(
//                        child: Text(
//                            'Error fetching data, please check your network'),
//                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  }),
    ));
  }

  checkAuth() async {
    var user = await FirebaseAuth.instance.currentUser();

    if (user != null) {
      appState.currentUser = user;
      setState(() {
        _checkingAuth = false;
      });
    } else {
      gotoHome();
    }
  }

  void gotoHome() {
    Future.delayed(Duration.zero,
        () => Router.gotoNamed(Routes.HOME, context, clearStack: true));
  }
}
