import 'dart:async';

import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:
              Theme.of(context).iconTheme.copyWith(color: Colors.grey[600]),
          backgroundColor: Colors.white,
          title: Text("Create Post",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(fontSize: 16.0, color: Colors.grey[600])),
          elevation: 2.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
//                  Router.gotoWidget(NewPostScreen(), context);
                },
                icon: Icon(Icons.save, color: Colors.white),
                label: Text(
                  "POST",
                  style: TextStyle(color: Colors.grey),
                ))
          ],
        ),
        body: Column(
          children: <Widget>[
            EmptySpace(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          InputDecoration.collapsed(hintText: "Post title"),
                      maxLines: 4,
                    ),
                    Divider(),
                    EmptySpace(),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                            hintText: "What is on your mind?"),
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            EmptySpace(),
            attachmentButton(
                'Select Photo/Camera',
                Icon(Icons.photo, color: ColorUtils.primaryColor),
                selectImageCamera),
//            attachmentButton('Document',
//                Icon(Icons.folder_open, color: ColorUtils.primaryColor)),
//            attachmentButton(
//                'Pdf', Icon(Icons.picture_as_pdf, color: Colors.red)),
          ],
        ));
  }

  Widget attachmentButton(String text, Icon icon, Function() onTap) {
    return Column(
      children: <Widget>[
        Divider(),
        ListTile(
          onTap: onTap,
          title: Text(text),
          dense: true,
          leading: icon,
          trailing: Icon(Icons.add),
        ),
      ],
    );
  }

  Future<void> selectImageCamera() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: true,
        maxImages: 5,
      );
    } on Exception catch (e) {
//      error = e.message;
      print(e);
    }

    if (!mounted) return;

    setState(() {
//      images = resultList;
//      if (error == null) _error = 'No Error Dectected';
    });
  }
}
