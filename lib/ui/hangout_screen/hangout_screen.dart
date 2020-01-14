import 'package:class_app/ui/hangout_screen/post_details_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:flutter/material.dart';

class HangoutScreen extends StatefulWidget {
  @override
  _HangoutScreenState createState() => _HangoutScreenState();
}

class _HangoutScreenState extends State<HangoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hangout", textAlign: TextAlign.center),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                "New Post",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
          color: ColorUtils.primaryColor[100],
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(
                      top: 6.0, bottom: 4.0, left: 8.0, right: 8.0),
                  child: Material(
                      shape: RoundedRectangleBorder(borderRadius: borderRadius),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PostDetailsScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: borderRadius),
                                padding: EdgeInsets.all(8.0),
                                child: Text("EXAMS",
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.white)),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  'Update on CS8214 - Postponed to next week due to unforseen circumstances.',
                                  style: Theme.of(context).textTheme.subtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    '10:40 AM',
                                    style: Theme.of(context).textTheme.caption,
                                  )),
                                  Icon(
                                    Icons.message,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '10',
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                );
              })),
    );
  }

  List<String> categories = [
    'All Notifications',
    'Important',
//    'Class',
//    'Test',
//    'Assignment',
//    'Exam',
//    'Sports',
//    'Religion',
    'Others'
  ];
  int selected = 0;

  List<Widget> getButtons() {
    List<Widget> list = [];
    for (var i = 0; i < categories.length; i++) {
      if (i == selected) {
        list.add(getButton(i, categories[i], true));
      } else {
        list.add(getButton(i, categories[i], false));
      }
    }
    /*var list = categories.map((title) => getButton(title, false)).toList();
    list[selected] = getButton(categories[selected], true);*/
    return list;
  }

  Widget getButton(int index, title, bool clicked) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () {
            setState(() {
              selected = index;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.subtitle),
              SizedBox(height: 5.0),
              Container(
                color: clicked ? Colors.black45 : Colors.transparent,
                height: 2,
                width: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
