//import 'dart:io';
//
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:peepoe/model/portfolio_dto.dart';
//import 'package:peepoe/ui/helper_widgets/empty_space.dart';
//import 'package:peepoe/ui/utils/color_utils.dart';
//
//class SelectImageDialog extends StatefulWidget {
//  @override
//  _SelectImageDialogState createState() => _SelectImageDialogState();
//}
//
//class _SelectImageDialogState extends State<SelectImageDialog> {
//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      content: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              OutlineButton.icon(
//                  onPressed: () =>
//                      Navigator.of(context).pop(ImageSource.camera),
//                  icon: Icon(Icons.camera_alt),
//                  label: Text("Camera")),
//              EmptySpace(multiple: 2),
//              OutlineButton.icon(
//                  onPressed: () =>
//                      Navigator.of(context).pop(ImageSource.gallery),
//                  icon: Icon(Icons.image),
//                  label: Text("Gallery"))
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//Future<File> pickImage(BuildContext context) async {
//  var source = await showDialog(
//      context: context,
//      builder: (context) {
//        return SelectImageDialog();
//      });
//
//  if (source != null) {
//    return getImage(source);
//  }
//  return null;
//}
//
//Future<File> getImage(ImageSource source) async {
//  return await ImagePicker.pickImage(source: source);
//}
//
//Future<dynamic> showUploadDialog(BuildContext context, File image, String path,
//    {UploadDTO portfolio}) async {
//  return await showDialog(
//      barrierDismissible: false,
//      context: context,
//      builder: (context) => UploadDialog(image, path, porfolio: portfolio));
//}
//
//class UploadDialog extends StatefulWidget {
//  UploadDialog(this.image, this.path, {this.porfolio});
//  File image;
//  String path;
//  UploadDTO porfolio;
//
//  @override
//  _UploadDialogState createState() => _UploadDialogState();
//}
//
//class _UploadDialogState extends State<UploadDialog> {
//  bool isUploading = false;
//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//      contentPadding: EdgeInsets.all(4.0),
//      content: Container(
//          height: MediaQuery.of(context).size.height / 2,
//          width: double.maxFinite,
//          child: Column(
//            children: <Widget>[
//              Expanded(
//                child: ClipRRect(
//                  borderRadius: BorderRadius.circular(8.0),
//                  child: Stack(
//                    children: <Widget>[
//                      Positioned.fill(
//                        child: Stack(
//                          children: <Widget>[
//                            Positioned.fill(
//                              child: Image.file(
//                                widget.image,
//                                fit: BoxFit.cover,
//                              ),
//                            ),
//                            Visibility(
//                              visible: widget.porfolio != null,
//                              child: Positioned(
//                                left: 0,
//                                right: 0,
//                                bottom: 0,
//                                child: Container(
//                                  padding: EdgeInsets.all(16.0),
//                                  color: Colors.black26,
//                                  child: TextField(
//                                    onChanged: (value) {
//                                      widget.porfolio.caption = value;
//                                    },
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 18),
//                                    decoration: InputDecoration.collapsed(
//                                      hintText: "Write a caption...",
//                                      hintStyle: TextStyle(
//                                          color: Colors.white, fontSize: 18),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                      Positioned.fill(
//                          child: Visibility(
//                        visible: isUploading,
//                        child: Container(
//                          padding: EdgeInsets.all(16.0),
//                          color: Colors.black87,
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              LinearProgressIndicator(),
//                              EmptySpace(),
//                              Row(
//                                children: <Widget>[
//                                  Text(
//                                    "Uploading...",
//                                    style: Theme.of(context)
//                                        .textTheme
//                                        .caption
//                                        .copyWith(color: Colors.white),
//                                  ),
//                                  Spacer(),
//                                  Text(
//                                    "$updateProgress/100",
//                                    style: Theme.of(context)
//                                        .textTheme
//                                        .caption
//                                        .copyWith(color: Colors.white),
//                                  )
//                                ],
//                              )
//                            ],
//                          ),
//                        ),
//                      ))
//                    ],
//                  ),
//                ),
//              ),
//              EmptySpace(),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  OutlineButton(
//                    borderSide: BorderSide(color: Colors.red),
//                    onPressed: isUploading
//                        ? null
//                        : () {
//                            Navigator.pop(context);
//                          },
//                    child: Text("Cancel"),
//                  ),
//                  EmptySpace(multiple: 2),
//                  OutlineButton(
//                    borderSide: BorderSide(color: ColorUtils.colorPrimary),
//                    onPressed: uploadFile,
//                    child: Text("Save"),
//                  ),
//                ],
//              )
//            ],
//          )),
//    );
//  }
//
//  String updateProgress = "0%";
//  uploadFile() {
//    setState(() {
//      isUploading = true;
//    });
//    StorageReference storageReference =
//        FirebaseStorage.instance.ref().child(widget.path);
//
//    print("Uploading profile picture...");
//
//    var uploadTask = storageReference.putFile(widget.image);
//    uploadTask.events.listen((event) {
//      var _progess = event.snapshot.bytesTransferred.toDouble() /
//          event.snapshot.totalByteCount.toDouble();
////      updateProgress("${(_progess*100).toInt()}%");
//
//      setState(() {
//        updateProgress = "${(_progess * 100).toInt()}%";
//      });
//      print(_progess.toString());
//    }).onError((error) {
////        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(error.toString()), backgroundColor: Colors.red,) );
//      Navigator.of(context).pop("");
//    });
//
//    uploadTask.onComplete.then((StorageTaskSnapshot snapShot) {
//      storageReference.getDownloadURL().then((url) {
//        print(url);
////        widget.getUrl(url, null);
//
//        if (widget.porfolio == null) {
//          Navigator.of(context).pop(url);
//        } else {
//          Navigator.of(context).pop(widget.porfolio..url = url);
//        }
//      }).catchError((e) {
////        print("Error");
////        getUrl("", e);
////        widget.getUrl("", e);
//
//        Navigator.pop(context);
//      });
//    });
//  }
//}
