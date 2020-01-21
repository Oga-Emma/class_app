import 'dart:async';
import 'dart:io';

import 'package:class_app/model/user_dto.dart';
import 'package:class_app/service/user_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/helper_widgets/toast_helper.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/error_handler.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:class_app/ui/widgets/profile_avatar.dart';
import 'package:class_app/ui/widgets/upload_image.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileSetupPage extends StatefulWidget {
  ProfileSetupPage({this.user});
  UserDTO user;
  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage>
    with UISnackBarProvider, ErrorHandler {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  UserDTO user;
  @override
  void initState() {
    if (widget.user != null) {
      user = widget.user;
    } else {
      user = UserDTO();
    }
    super.initState();
  }

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.user == null ? 'Create Profile' : 'Edit Profile'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
                onPressed: _saveChanges,
                child: Text(
                  "SAVE",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                profilePicture(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: user.firstName,
                        decoration: InputDecoration(labelText: "First Name"),
                        validator: Validators.validateAlpha(),
                        onSaved: (value) {
                          user.firstName = value;
                        },
                      ),
                      EmptySpace(),
                      TextFormField(
                        initialValue: user.lastName,
                        decoration: InputDecoration(labelText: "Last Name"),
                        validator: Validators.validateAlpha(),
                        onSaved: (value) {
                          user.lastName = value;
                        },
                      ),
//                      EmptySpace(),
//                      TextFormField(
//                        decoration: InputDecoration(labelText: "Gender"),
//                        validator: Validators.validateAlpha(),
//                        onSaved: (value) {
//                          user.firstName = value;
//                        },
//                      ),
                      EmptySpace(),
                      TextFormField(
                        enabled: false,
                        initialValue: appState.currentUser.email,
                        decoration: InputDecoration(labelText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail(),
                        onSaved: (value) {
                          user.email = value;
                        },
                      ),
                      EmptySpace(),
                      TextFormField(
                        initialValue: user.phoneNumber,
                        decoration: InputDecoration(labelText: "Phone Number"),
                        keyboardType: TextInputType.phone,
                        validator: Validators.validatePhone(),
                        onSaved: (value) {
                          user.phoneNumber = value;
                        },
                      ),
//                      EmptySpace(),
//                      TextFormField(
//                        decoration: InputDecoration(labelText: "Date of Birth"),
//                        validator: Validators.validateAlpha(),
//                        onSaved: (value) {
//                          user.firstName = value;
//                        },
//                      ),
                      EmptySpace(multiple: 2),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  File selectedPicture;
  Future<void> selectPicture() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedPicture = image;
      });
    }
  }

  profilePicture() {
    return Container(
      color: ColorUtils.primaryColor,
      padding: EdgeInsets.all(24.0),
      child: Center(
        child: Stack(
          children: <Widget>[
            ProfileAvatar(
              radius: 70,
              url: user.profilePicture,
              file: selectedPicture,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.red,
                child: InkWell(
                  onTap: selectPicture,
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Future<void> _saveChanges() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      showLoadingSnackBar();

      try {
        user..id = appState.currentUser.uid;

        if (selectedPicture != null) {
          String url = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => UploadImage(
                    selectedPicture,
                    "users/${user.id}",
                    "Uploading profile picture",
                  ));
          if (url != null && url.isNotEmpty) {
            user..profilePicture = url;
          } else {
            showErrorToast('image upload failed');
          }
        }
        await UserDAO.saveUser(user);
        appState.user = user;

        if (widget.user == null) {
          Navigator.pop(context);
        } else {
          showInSnackBar("Changes saved");
        }
      } catch (err) {
        showInSnackBar(getErrorMessage(err));
      }
    } else {
      showInSnackBar("Correct all errors in red");
    }
  }
}
