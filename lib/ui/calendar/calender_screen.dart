import 'dart:async';

import 'package:class_app/model/date_event.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/service/event_dao.dart';
import 'package:class_app/service/lecture_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/calendar/calendar_fixed.dart';
import 'package:class_app/ui/list_items/calendar_events_list_item.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen(this.appState);
  AppStateProvider appState;

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
//  final Map _events = {
//    DateTime(2019, 7, 21): [
//      {'name': 'Event A', 'isDone': true},
//    ],
//    DateTime(2019, 7, 22): [
//      {'name': 'Event A', 'isDone': true},
//      {'name': 'Event B', 'isDone': true},
//    ],
//    DateTime(2019, 7, 23): [
//      {'name': 'Event A', 'isDone': true},
//      {'name': 'Event B', 'isDone': true},
//    ],
//    DateTime(2019, 7, 25): [
//      {'name': 'Event A', 'isDone': true},
//      {'name': 'Event B', 'isDone': true},
//      {'name': 'Event C', 'isDone': false},
//      {'name': 'Event B', 'isDone': true},
//      {'name': 'Event C', 'isDone': false},
//    ],
//    DateTime(2019, 7, 24): [
//      {'name': 'Event A', 'isDone': true},
//      {'name': 'Event B', 'isDone': true},
//      {'name': 'Event C', 'isDone': false},
//    ],
//    DateTime(2019, 7, 26): [
//      {'name': 'Event A', 'isDone': false},
//    ],
//  };

  bool _expanded = false;
  DateTime _today = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    appState = widget.appState;
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _events = <DateTime, List<Map<String, dynamic>>>{};
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
//    print("Selected day = ${_selectedDate.toString()}");
//    print(_events);

    /*return Container(
      color: ColorUtils.primaryColor,
      child: Column(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: Container(
              color: ColorUtils.primaryColor,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 8.0),
              color: Colors.grey[100],
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    floating: true,
                    snap: true,

                    title: Text('Events'),
//          backgroundColor: Colors.green,
                    expandedHeight: _expanded ? 450 : 240.0,
                    flexibleSpace: FlexibleSpaceBar(
                        background: SafeArea(
                            child:
                                calendar) //Image.asset('assets/forest.jpg', fit: BoxFit.cover),
                        ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                        List.generate(10, (index) => CalendarEventListItem())
                        */ /*[
                        Container(color: Colors.red),
                        Container(color: Colors.purple),
                        Container(color: Colors.green),
                        Container(color: Colors.orange),
                        Container(color: Colors.yellow),
                        Container(color: Colors.pink),
                      ],*/ /*
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );*/

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("Events"),
                expandedHeight: _expanded ? 450 : 220.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
//                  centerTitle: true,
                    background: SafeArea(
                  child: getCalendar(_events),
                )),
              ),
              /*SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.info), text: "Tab 1"),
                    Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                  ],
                ),
              ),
              pinned: true,
            ),*/
            ];
          },
          body: StreamBuilder<EventLectures>(
              stream: fetchDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var dateEvents = <DateEvent>[];

                  var lectures = snapshot.data.lectures
                      .where((lec) => lec.day == _selectedDate.weekday);

                  lectures.forEach((lec) {
                    var split = lec.startTime.split(":");
                    lec.timeStamp = DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            int.parse(split[0]),
                            int.parse(split[1]))
                        .millisecondsSinceEpoch;
                  });
                  dateEvents.addAll(lectures);

                  dateEvents.addAll(snapshot.data.events.where((evt) =>
                      evt.timeStamp == _selectedDate.millisecondsSinceEpoch));

                  dateEvents.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));

                  if (dateEvents.isEmpty) {
                    return noEvent();
                  }

                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                        return CalendarEventListItem(dateEvents[index]);
                      }, childCount: dateEvents.length)),
                    ],
                  );
                }

                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text("Error fetching data"));
                }

                return Loading();
              })),
    );

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(height: 100, color: ColorUtils.primaryColor),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          elevation: 8.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CalendarFixed(
                                events: _events,
                                onRangeSelected: (range) => print(
                                    "Range is ${range.from}, ${range.to}"),
                                onDateSelected: (date) => _handleNewDate(date),
                                isExpandable: true,
                                showTodayIcon: true,
                                eventDoneColor: ColorUtils.primaryColor,
                                selectedColor: ColorUtils.accentColor,
                                eventColor: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                children: <Widget>[
                  Text("Today"),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Container(); //CalendarEventListItem();
                        }),
                  ),
                ],
              ),
            ))
          ],
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
          Image.asset(
            "assets/img/no_event.png",
            height: 120,
            width: 120,
          ),
          gap,
          Text("No event today"),
          Text("Any new event will appear here"),
          gap2x
        ],
      ),
    );
  }

  _handleNewDate(DateTime date) {
    print("changed");
    _selectedDate = date;
    setState(() {});
  }

  var dateEvents = <DateEvent>[];
  Observable<EventLectures> fetchDataStream;
  void fetchData() {
    fetchDataStream = Observable.combineLatest2(
        LectureDAO.fetchAllLectures(appState.appInfo),
        EventDAO.fetchAllEvents(appState.appInfo),
        (QuerySnapshot lecturesSnapshot, QuerySnapshot eventsSnapshot) {
      print("Fetching done");

      var eventLectures = EventLectures();
      var lectures = <LectureDTO>[];
      var lectures2 = <LectureDTO>[];
      var events = <EventDTO>[];

      LectureDTO lecture;
      for (DocumentSnapshot lect in lecturesSnapshot.documents) {
        lecture = LectureDTO.fromJson(lect.data);
        lectures.add(lecture);
        lectures2.add(lecture);
      }

      EventDTO event;
      for (DocumentSnapshot evt in eventsSnapshot.documents) {
        event = EventDTO.fromJson(evt.data);
        events.add(event);
      }

      eventLectures.lectures = lectures;
      eventLectures.events = events;

//      {'name': 'Event A', 'isDone': false},
      if (_events.isEmpty && (events.isNotEmpty || lectures.isNotEmpty)) {
        var monDay = _today.weekday == 1
            ? _today
            : _today.subtract(Duration(days: _today.weekday - 1));

        /////////////////MONDAY THIS WEEK WEEK/////////////////////
        monDay = DateTime(monDay.year, monDay.month, monDay.day);

        print("TODAY => ${_today.toString()}");
        print("MONDAY => ${monDay.toString()}");

        lectures.forEach((lec) => lec.timeStamp =
            monDay.add(Duration(days: lec.day - 1)).millisecondsSinceEpoch);

        lectures.forEach((ev) =>
            _events[DateTime.fromMillisecondsSinceEpoch(ev.timeStamp)] = []);

        lectures.forEach((ev) =>
            _events[DateTime.fromMillisecondsSinceEpoch(ev.timeStamp)].add({
              'name': 'Lecture - ${ev.course.title}',
              'isDone': ev.timeStamp < _today.millisecondsSinceEpoch
            }));

        print("after week 1 => $_events");

        /////////////////MONDAY NEXT WEEK/////////////////////
        var monDayNext = monDay.add(Duration(days: 7));
        print("MONDAY NEXT => ${monDay.toString()}");

        lectures2.forEach((lec) => lec.timeStamp =
            monDayNext.add(Duration(days: lec.day - 1)).millisecondsSinceEpoch);

        lectures2.forEach((ev) =>
            _events[DateTime.fromMillisecondsSinceEpoch(ev.timeStamp)] = []);

        lectures2.forEach((ev) =>
            _events[DateTime.fromMillisecondsSinceEpoch(ev.timeStamp)].add({
              'name': 'Lecture - ${ev.course.title}',
              'isDone': ev.timeStamp < _today.millisecondsSinceEpoch
            }));
        /////////////////MONDAY NEXT WEEK/////////////////////

        events.forEach((ev) {
          if (_events[DateTime.fromMillisecondsSinceEpoch(ev.timeStamp)] ==
              null) {
            _events[DateTime.fromMillisecondsSinceEpoch(ev.timeStamp)] = [];
          }
        });

/*
        lectures.forEach((ev) =>
            _events[DateTime.fromMillisecondsSinceEpoch(ev.timeStamp)]
                .add({'name': 'Event - A', 'isDone': true}));*/

        events.forEach((ev) =>
            _events[DateTime.fromMillisecondsSinceEpoch(ev.timeStamp)].add({
              'name': '${ev.title}',
              'isDone': ev.timeStamp < _today.millisecondsSinceEpoch
            }));

//        _events.forEach((x, y) => y.add({'name': 'Event - A', 'isDone': true}));
//
//        print(_events);
        setState(() {});
      }
      return eventLectures;
    });
  }

  getCalendar(Map<DateTime, List<Map<String, dynamic>>> events) {
    print("events in get calendar => $events");
    /*events = {
      DateTime(2019, 7, 21): [
        {'name': 'Event A', 'isDone': true},
      ],
      DateTime(2019, 7, 22): [
        {'name': 'Event A', 'isDone': true},
        {'name': 'Event B', 'isDone': true},
      ],
      DateTime(2019, 7, 23): [
        {'name': 'Event A', 'isDone': true},
        {'name': 'Event B', 'isDone': true},
      ],
      DateTime(2019, 7, 25): [
        {'name': 'Event A', 'isDone': true},
        {'name': 'Event B', 'isDone': true},
        {'name': 'Event C', 'isDone': false},
        {'name': 'Event D', 'isDone': true},
        {'name': 'Event E', 'isDone': false},
      ],
      DateTime(2019, 7, 24): [
        {'name': 'Event A', 'isDone': true},
        {'name': 'Event B', 'isDone': true},
        {'name': 'Event C', 'isDone': false},
      ],
      DateTime(2019, 7, 26): [
        {'name': 'Event A', 'isDone': false},
      ],
    };*/

    return Container(
      color: Colors.grey[200],
      child: Stack(
        children: <Widget>[
          Container(height: 120, color: ColorUtils.primaryColor),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  elevation: 8.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CalendarFixed(
                        sizeChanged: (expanded) async {
                          if (!expanded) {
                            await Future.delayed(Duration(milliseconds: 400));
                          }

                          setState(() {
                            _expanded = expanded;
                          });
                        },
                        isExpanded: _expanded,
                        events: events,
                        onRangeSelected: (range) =>
                            print("Range is ${range.from}, ${range.to}"),
                        onDateSelected: (date) => _handleNewDate(date),
                        isExpandable: true,
                        showTodayIcon: true,
                        eventDoneColor: ColorUtils.primaryColor,
                        selectedColor: ColorUtils.accentColor,
                        eventColor: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class EventLectures {
  List<EventDTO> events = [];
  List<LectureDTO> lectures = [];
}
