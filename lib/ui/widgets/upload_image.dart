import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'empty_space.dart';

class UploadImage extends StatefulWidget {
  String bucket;
  String title;
  File file;
//  Function(String url, Error e) getUrl;

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              emptySpace(multiple: 2),
              Text(
                "${updateProgress.toStringAsFixed(1)}%",
                style:
                    Theme.of(context).textTheme.headline.copyWith(fontSize: 18),
              ),
            ],
          ),
          emptySpace(),
          LinearProgressIndicator()
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () async {
              if (uploadTask != null && !uploadTask.isCanceled) {
                if (uploadTask.isComplete) {
                  Navigator.pop(
                      context, await storageReference.getDownloadURL());
                } else {
                  uploadTask.cancel();
                  Navigator.pop(context);
                }
              }
            },
            child: Text("Cancel Upload"))
      ],
    );
  }

  double updateProgress = 0;
  StorageUploadTask uploadTask;
  StorageReference storageReference;
  uploadFile() async {
    storageReference = FirebaseStorage.instance.ref().child(widget.bucket);

    print("Uploading profile picture...");
    uploadTask = storageReference.putFile(widget.file);
    uploadTask.events.listen((event) {
      var _progess = event.snapshot.bytesTransferred.toDouble() /
          event.snapshot.totalByteCount.toDouble();
      setState(() {
        updateProgress = (_progess * 100);
      });
      print(updateProgress.toString());
    }).onError((error) {
      Navigator.of(context).pop("");
    });

    uploadTask.onComplete.then((StorageTaskSnapshot snapShot) {
      storageReference.getDownloadURL().then((url) {
        print("UPLOAD DONE $url");
        Navigator.of(context).pop(url);
      }).catchError((e) {
        if (mounted) {
          Navigator.of(context).pop("");
        }
      });
    });
  }
}
