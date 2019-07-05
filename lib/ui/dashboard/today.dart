import 'package:class_app/model/date_event.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/ui/list_items/combined_list_item_user.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  Today({@required this.events, this.date});

  final List<DateEvent> events;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back, size: 36,
                  color: ColorUtils.primaryColor,)),
                gap,
                Text("TODAY EVENTS", style: Theme.of(context).textTheme.title.copyWith(fontSize: 32, color: ColorUtils.primaryColor)),
                Text(date, style: Theme.of(context).textTheme.subhead.copyWith(color: ColorUtils.accentColor)),
                SizedBox(height: 50.0),
                Expanded(
                    child: events.isEmpty ? noEvent() : ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return CombinedListItemUser(events[index], onTap: (event){
                          },);
                        })
                )
              ],
            ),
          )),
    );
  }

  List<String> categories = [
    'Classes',
    'Others'
  ];
  int selected = 0;

  List<Widget> getButtons(BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < categories.length; i++) {
      if (i == selected) {
        list.add(getButton(context, i, categories[i], true));
      } else {
        list.add(getButton(context, i, categories[i], false));
      }
    }
    /*var list = categories.map((title) => getButton(title, false)).toList();
    list[selected] = getButton(categories[selected], true);*/
    return list;
  }

  Widget getButton(BuildContext context, int index, title, bool clicked) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () {
            /*setState(() {
              selected = index;
            });*/
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

  noEvent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/img/no_event.png", height: 120, width: 120,),
          gap,
          Text("No event today"),
          Text("Any new event will appear here"),
          gap2x
        ],
      ),
    );
  }
}
