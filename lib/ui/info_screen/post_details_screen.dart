import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class PostDetailsScreen extends StatefulWidget {
  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  var _bottomSheetController = SolidController();

  @override
  void dispose() {
    _bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          title: Text("Post"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.share), onPressed: () {})
          ],
        ),
//        bottomSheet: SolidBottomSheet(
//          controller: _bottomSheetController,
//          autoSwiped: true,
//          toggleVisibilityOnTap: true,
//          maxHeight: MediaQuery.of(context).size.height -
//              MediaQuery.of(context).size.height ~/ 4,
//          headerBar: Container(
//            color: Theme.of(context).primaryColor,
//            height: 0,
//          ),
//          body: Container(),
//        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('GENERAL',
                        style: textStyle.body2.copyWith(fontSize: 12.0)),
                    EmptySpace(),
                    Text('How i made \$200,000 when i was 16 years old.',
                        style: textStyle.headline),
                    SizedBox(
                        width: 70,
                        child: Divider(
                          color: ColorUtils.primaryColor,
                          thickness: 1.5,
                        )),
                    EmptySpace(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Container(
                        height: 200,
                        color: Colors.grey[300],
                      ),
                    ),
                    EmptySpace(),
                    Row(
                      children: <Widget>[
                        ProfileAvatar(radius: 20),
                        EmptySpace(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Oga Emma'),
                              EmptySpace(multiple: 0.5),
                              Text('Today | 12:32pm', style: textStyle.caption),
                            ],
                          ),
                        )
                      ],
                    ),
                    EmptySpace(),
                    Text(
                      "Hello" * 200,
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return PostComments();
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[Text('Your comment')],
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }
}

class PostComments extends StatefulWidget {
  @override
  _PostCommentsState createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: 48),
        color: Colors.black26,
        child: Material(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Comments (20)',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(fontSize: 18)),
                          ),
                          InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.close),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    ),
                    Divider(),
                    Expanded(
                        child: ListView.builder(itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ProfileAvatar(radius: 20),
                            EmptySpace(),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  color:
                                      ColorUtils.primaryColor.withOpacity(0.1),
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Oga Emma',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline
                                              .copyWith(fontSize: 16)),
                                      EmptySpace(),
                                      Text("Hello world" * 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }))
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 0.0),
                              margin: EdgeInsets.all(4.0),
                              child: TextField(
                                decoration: InputDecoration.collapsed(
                                    hintText: "Say something..."),
                                minLines: 1,
                                maxLines: 5,
                              ))),
                      IconButton(
                          icon:
                              Icon(Icons.send, color: ColorUtils.primaryColor),
                          onPressed: () {})
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, -1),
                        blurRadius: 10,
                        spreadRadius: .8),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
