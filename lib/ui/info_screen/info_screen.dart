import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:class_app/ui/info_screen/new_post_screen.dart';
import 'package:class_app/ui/info_screen/post_details_screen.dart';
import 'package:class_app/ui/info_screen/recent_posts.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
//          brightness: Brightness.light,
          title: Text("Information", textAlign: TextAlign.center),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  Router.gotoWidget(NewPostScreen(), context);
                },
                icon: Icon(Icons.add, color: ColorUtils.primaryColor),
                label: Text(
                  "New Post",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
            color: ColorUtils.primaryColor[100],
            child: Column(
              children: <Widget>[
                Material(
                  elevation: 2.0,
                  child: TabBar(
                      unselectedLabelColor: Colors.grey[600],
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BubbleTabIndicator(
                        indicatorHeight: 30.0,
                        indicatorColor: ColorUtils.primaryColor,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                      tabs: [
                        Tab(text: "FEATURED"),
                        Tab(text: "TOP POST"),
                        Tab(text: "RECENT"),
                      ]),
                ),
                Expanded(
                  child: TabBarView(children: [
                    PostsList(),
                    PostsList(),
                    PostsList(),
                  ]),
                ),
              ],
            )),
      ),
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
