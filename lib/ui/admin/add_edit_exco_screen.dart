import 'dart:async';
import 'dart:io';

import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/exco_dto.dart';
import 'package:class_app/service/exco_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/fixed_dropdown.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class AddEditExco extends StatefulWidget {
  AddEditExco(this.exco);

  final ExcoDTO exco;
  @override
  _AddEditExcoState createState() => _AddEditExcoState();
}

class _AddEditExcoState extends State<AddEditExco> with UISnackBarProvider {

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var excoTypeError = false;
  var genderError = false;
  var _gender = "MALE";
  var _excoType = ExcoType.COURSE_REP;

  @override
  void initState() {
    if(widget.exco.gender.isNotEmpty) {
      _gender = widget.exco.gender;
    }
    if(widget.exco.type.isNotEmpty) {
      _excoType = widget.exco.type;
    }
    super.initState();
  }

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Exco Details", textAlign: TextAlign.center)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(image: _image != null ?
                            FileImage(_image) :
                            CachedNetworkImageProvider(widget.exco.imageUrl),
                                fit: BoxFit.cover
                            )

                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        color: Colors.black.withOpacity(0.4),
                        child: InkWell(
                          onTap: selectImage,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Click to change", style: TextStyle(color: Colors.white),),
                              gap,
                              Icon(Icons.camera_alt, color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              gap2x,
              gap2x,
              Stack(
                children: <Widget>[
                  Container(height: 60),
                  Positioned(
                    top: 8.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
//                            width: double.infinity,
                      child: FixedDropdownButton<String>(
                        hint: Text('Select the exco type'),
                        value: _excoType,
                        items: [ExcoType.EXCO, ExcoType.COURSE_REP].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(child: Text(value)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _excoType = value;
                          });
                        },
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: excoTypeError ? Colors.red : Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 8.0,
                      child: Container(
                          padding: EdgeInsets.only(left: 4.0, right: 4.0),
                          color: Colors.grey[50],
                          child: Text("EXCO TYPE",
                              style: TextStyle(fontSize: 12.0)))),
                ],
              ),
              gap2x,
              STextField(
                initialValue: widget.exco.firstName,
                label: "FIRST NAME",
                onSaved: (value) {
                  widget.exco.firstName = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please first name";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gap2x,
              STextField(
                initialValue: widget.exco.lastName,
                label: "LAST NAME",
                onSaved: (value) {
                  widget.exco.lastName = value;
                  },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter last name";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gap2x,
              STextField(
                initialValue: widget.exco.otherName,
                label: "OTHER NAME",
                onSaved: (value) {
                  widget.exco.otherName = value;
                },
//              hint: "Course Code",
              ),
              gap2x,
              Stack(
                children: <Widget>[
                  Container(height: 60),
                  Positioned(
                    top: 8.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
//                            width: double.infinity,
                      child: FixedDropdownButton<String>(
                        hint: Text('Select gender'),
                        value: _gender,
                        items: ["MALE", "FEMALE", "OTHERS"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(child: Text(value)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: genderError ? Colors.red : Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 8.0,
                      child: Container(
                          padding: EdgeInsets.only(left: 4.0, right: 4.0),
                          color: Colors.grey[50],
                          child: Text("GENDER",
                              style: TextStyle(fontSize: 12.0)))),
                ],
              ),
              gap2x,
              STextField(
                initialValue: widget.exco.phone,
                label: "PHONE NUMBER",
                onSaved: (value) {
                  widget.exco.phone = value;
                  },
//              hint: "Course Code",
              ),
              gap2x,
              STextField(
                initialValue: widget.exco.post,
                label: "POST",
                onSaved: (value) {
                  widget.exco.post = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter post";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gap2x,
              SButton(
                labelText: "SAVE CHANGES",
                onTap: saveChanges,
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveChanges() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      widget.exco.type = _excoType;
      widget.exco.gender = _gender;

      showLoadingSnackBar();

      if(_image != null){
        String url = await showDialog(context: context,
            builder: (context) => UploadImage(_image,
                "images/excos/${widget.exco.id}",
                "Uploading exco image..."));

        if(url != null && url.isNotEmpty){
          widget.exco.imageUrl = url;
          showError(message: "Could not upload image");
        }
      }

      ExcoDAO.saveExco(appState.appInfo, widget.exco, (success){
        if(success){
          showInSnackBar("Changes saved");
          Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));

        }else{
          showInSnackBar("Error saving changes, please check your network and try again");
        }
      });

//      print(widget.course.toMap());
    }else{
      showInSnackBar("Please review the errors in red");
    }
  }

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void selectImage() {
    getImage();
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

}


class UploadImage extends StatefulWidget {
  String bucket;
  String title;
  File file;
  Function(String url, Error e) getUrl;

  UploadImage(this.file, this.bucket, this.title);
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  @override
  void initState() {
    uploadFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(widget.title),
          Text(updateProgress, style: Theme.of(context).textTheme.display1,),
          LinearProgressIndicator()
        ],
      ),
    );
  }

  String updateProgress = "0%";
  uploadFile() {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(widget.bucket);

    print("Uploading profile picture...");

    var uploadTask = storageReference.putFile(widget.file);
    uploadTask.events.listen((event) {
      var _progess = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
//      updateProgress("${(_progess*100).toInt()}%");

      setState(() {
        updateProgress = "${(_progess*100).toInt()}%";
      });
      print(_progess.toString());
    }).onError((error) {
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(error.toString()), backgroundColor: Colors.red,) );
      Navigator.of(context).pop("");
    });

    uploadTask.onComplete
        .then((StorageTaskSnapshot snapShot) {
      storageReference.getDownloadURL().then((url) {
        print(url);
//        widget.getUrl(url, null);

        Navigator.of(context).pop(url);

      }).catchError((e) {
//        print("Error");
//        getUrl("", e);
//        widget.getUrl("", e);

        Navigator.of(context).pop("");
      });
    });
  }
}
