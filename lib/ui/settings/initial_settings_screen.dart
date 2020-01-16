import 'dart:async';

import 'package:class_app/model/department_dto.dart';
import 'package:class_app/model/school_dto.dart';
import 'package:class_app/service/firebase/app_settings_dao.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class InitialSettingsScreen extends StatefulWidget {
  @override
  _InitialSettingsScreenState createState() => _InitialSettingsScreenState();
}

class _InitialSettingsScreenState extends State<InitialSettingsScreen>
    with UISnackBarProvider {
  var _formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  SchoolDTO selectedSchool;
  DepartmentDTO selectedDepartment;

  var schoolController = TextEditingController();
  var departmentController = TextEditingController();

  @override
  void dispose() {
    schoolController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[200],
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.grey[700]),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EmptySpace(),
                  Text("Welcome", style: Theme.of(context).textTheme.headline),
                  EmptySpace(),
                  Text(
                      "Please select your school and department/class below to get started"),
                  EmptySpace(multiple: 3),
                  InkWell(
                    onTap: selectInstitution,
                    child: IgnorePointer(
                      ignoring: true,
                      child: TextFormField(
                          controller: schoolController,
                          decoration:
                              InputDecoration(labelText: "School/Institution")),
                    ),
                  ),
                  EmptySpace(multiple: 3),
                  InkWell(
                    onTap: selectDepartment,
                    child: IgnorePointer(
                      ignoring: true,
                      child: TextFormField(
                          controller: departmentController,
                          decoration: InputDecoration(labelText: "Department")),
                    ),
                  ),
                  EmptySpace(multiple: 5),
                  CAButton(title: "Continue", onPressed: continueSetup),
                  EmptySpace(multiple: 2),
                  Wrap(
                    children: <Widget>[
                      Text(
                        "If you can't find your school or department",
                        textAlign: TextAlign.center,
                      ),
                      EmptySpace(),
                      InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Click Here To Register Them",
                                style:
                                    TextStyle(color: ColorUtils.primaryColor)),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> selectInstitution() async {
    SchoolDTO school = await showDialog(
            context: context, builder: (context) => InstitutionDialog()) ??
        null;

    if (school != null) {
      schoolController.text = "${school.name} (${school.code})".toUpperCase();
      setState(() {
        selectedSchool = school;
      });
    }
  }

  Future<void> selectDepartment() async {
    if (this.selectedSchool == null) {
//      show error
      showInSnackBar("Please select your institution/school first");
      return;
    }
    DepartmentDTO department = await showDialog(
            context: context,
            builder: (context) => DepartmentDialog(this.selectedSchool.id)) ??
        null;

    if (department != null) {
      departmentController.text =
          "${department.name} (${department.entryYear})".toUpperCase();
      setState(() {
        selectedDepartment = department;
      });
    }
  }

  Future<void> continueSetup() async {
    if (this.selectedSchool == null) {
//      show error
      showInSnackBar("Please select your institution/school");
      return;
    }
    if (this.selectedDepartment == null) {
//      show error
      showInSnackBar("Please select your department/class");
      return;
    }
  }
}

class InstitutionDialog extends StatefulWidget {
  @override
  _InstitutionDialogState createState() => _InstitutionDialogState();
}

class _InstitutionDialogState extends State<InstitutionDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: StreamBuilder<QuerySnapshot>(
          stream: Observable.fromFuture(appSettingDao.getSchools()),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return buildBody(snapshot.data.documents);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  SchoolDTO selectedSchool;
  buildBody(List<DocumentSnapshot> documents) {
    return Column(
      children: <Widget>[
        Text("Select your institution/school below"),
        Divider(),
        Expanded(
            child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var school = SchoolDTO.fromMap(documents[index].data)
                    ..id = documents[index].documentID;

                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedSchool = school;
                      });
                    },
                    selected: selectedSchool != null &&
                        selectedSchool.id == school.id,
                    title: Text("${school.code}".toUpperCase()),
                    subtitle: Text("${school.name}"),
                    trailing: Icon(Icons.chevron_right),
                  );
                })),
        Divider(),
        CAButton(
            title: "Select",
            onPressed: selectedSchool == null
                ? null
                : () => Navigator.of(context).pop(selectedSchool))
      ],
    );
  }
}

class DepartmentDialog extends StatefulWidget {
  DepartmentDialog(this.schoolId);
  String schoolId;
  @override
  _DepartmentDialogState createState() => _DepartmentDialogState();
}

class _DepartmentDialogState extends State<DepartmentDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: StreamBuilder<QuerySnapshot>(
          stream: Observable.fromFuture(
              appSettingDao.getDepartments(widget.schoolId)),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return buildBody(snapshot.data.documents);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  DepartmentDTO selectedDepartment;
  buildBody(List<DocumentSnapshot> documents) {
    return Column(
      children: <Widget>[
        Text("Select your class/department below"),
        Divider(),
        Expanded(
            child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var department = DepartmentDTO.fromMap(documents[index].data)
                    ..id = documents[index].documentID;

                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedDepartment = department;
                      });
                    },
                    selected: selectedDepartment != null &&
                        selectedDepartment.id == department.id,
                    title: Text(
                        "${department.departmentCode} (${department.entryYear} - ${department.graduationYear})"
                            .toUpperCase()),
                    subtitle: Text("${department.name}"),
                    trailing: Icon(Icons.chevron_right),
                  );
                })),
        Divider(),
        CAButton(
            title: "Select",
            onPressed: selectedDepartment == null
                ? null
                : () => Navigator.of(context).pop(selectedDepartment))
      ],
    );
  }
}
