import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:class_app/service/post_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/info_screen/new_post_screen.dart';
import 'package:class_app/ui/info_screen/post_details_screen.dart';
import 'package:class_app/ui/info_screen/posts_list.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
//          brightness: Brightness.light,
          title: Text("Information", textAlign: TextAlign.center),
          elevation: 0.0,
          actions: <Widget>[
            Visibility(
              visible: appState.isSuperAdmin,
              child: FlatButton(
                  onPressed: () {
                    Router.gotoWidget(NewEditPostScreen(), context);
                  },
                  child: Text(
                    "New Post",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        body: Container(
            color: Colors.grey[200],
            child: Column(
              children: <Widget>[
                Material(
                  elevation: 2.0,
                  child: TabBar(
                      unselectedLabelColor: Colors.grey[600],
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BubbleTabIndicator(
                        indicatorRadius: 4.0,
                        indicatorHeight: 36.0,
                        indicatorColor: ColorUtils.primaryColor,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                      tabs: [
                        Tab(text: "RECENT"),
                        Tab(text: "TRENDING"),
//                        Tab(text: "CATEGORY"),
                      ]),
                ),
                Expanded(
                  child: TabBarView(children: [
                    RecentPosts(),
                    TrendingPosts()
//                    PostsList(),
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

class RecentPosts extends StatelessWidget {
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Observable.fromFuture(PostDAO.getRecentPosts(appState.appInfo)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PostsList(snapshot.data.documents);
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text("Error fetching data"));
          }
          return Loading();
        });
  }
}

class TrendingPosts extends StatelessWidget {
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return StreamBuilder<QuerySnapshot>(
        stream:
            Observable.fromFuture(PostDAO.getTrendingPosts(appState.appInfo)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PostsList(snapshot.data.documents);
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text("Error fetching data"));
          }
          return Loading();
        });
  }
}
