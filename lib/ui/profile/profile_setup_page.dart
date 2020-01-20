import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';

class ProfileSetupPage extends StatefulWidget {
  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Edit Profile'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
                onPressed: () {},
                child: Text(
                  "SAVE",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Column(
          children: <Widget>[
            profilePicture(),

          ],
        ));
  }

  void selectPicture() {}

  profilePicture() {
    return Container(
      color: ColorUtils.primaryColor,
      padding: EdgeInsets.all(24.0),
      child: Center(
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
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
}
