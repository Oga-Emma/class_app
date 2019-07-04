import 'package:class_app/ui/list_items/lecture_list_item.dart';
import 'package:class_app/ui/shared/LectureListBuilder.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';

class Classes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
                height: 50.0,
                child: TabBar(
                  isScrollable: true,
                  tabs: ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat"].map((str) => Padding(
                    padding: const EdgeInsets.all(4.0),
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
              LectureListBuilder(day: 1),
              LectureListBuilder(day: 2),
              LectureListBuilder(day: 3),
              LectureListBuilder(day: 4),
              LectureListBuilder(day: 5),
              LectureListBuilder(day: 6),
            ],
          ),
        ),
      ),
    );
  }
}


