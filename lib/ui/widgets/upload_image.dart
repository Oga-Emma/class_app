import 'dart:io';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UploadImage extends StatefulWidget {
  String bucket;
  String title;
  File file;
  Asset asset;
//  Function(String url, Error e) getUrl;

  UploadImage(this.file, this.bucket, this.title, {this.asset = null});
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
              EmptySpace(multiple: 2),
              Text(
                "${updateProgress.toStringAsFixed(1)}%",
                style:
                    Theme.of(context).textTheme.headline.copyWith(fontSize: 18),
              ),
            ],
          ),
          EmptySpace(),
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

    if (widget.asset != null) {
      ByteData byteData = await widget.asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      uploadTask = storageReference.putData(imageData);

//      return await (await uploadTask.onComplete).ref.getDownloadURL();
    } else {
      uploadTask = storageReference.putFile(widget.file);
    }
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
