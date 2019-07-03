import 'package:class_app/ui/list_items/lecture_list_item.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';

class Classes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
                height: 50.0,
                child: TabBar(
                  tabs: ["Mon", "Tue", "Wed", "Thur", "Fri"].map((str) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      str,
                      style: TextStyle(fontSize: 16, color: ColorUtils.primaryColor),
                    ),
                  ),).toList(),
                ))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: 4,
                  itemBuilder: (context, index) => LectureListItem()),
              ListView.builder(
                itemCount: 4,
                  itemBuilder: (context, index) => LectureListItem()),
              ListView.builder(
                itemCount: 4,
                  itemBuilder: (context, index) => LectureListItem()),
              ListView.builder(
                itemCount: 4,
                  itemBuilder: (context, index) => LectureListItem()),
              ListView.builder(
                itemCount: 4,
                  itemBuilder: (context, index) => LectureListItem()),
            ],
          ),
        ),
      ),
    );
  }
}


