import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/exco_dto.dart';
import 'package:class_app/service/event_dao.dart';
import 'package:class_app/ui/event/event_details_screen.dart';
import 'package:class_app/ui/exco/exco_user.dart';
import 'package:class_app/ui/list_items/event_list_item_user.dart';
import 'package:class_app/ui/list_items/exco_list_item.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassExcoScreen extends StatefulWidget {
  @override
  _ClassExcoScreenState createState() => _ClassExcoScreenState();
}

class _ClassExcoScreenState extends State<ClassExcoScreen> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {

    var selectedDecoration = BoxDecoration(
        color: ColorUtils.primaryColor,
        borderRadius: BorderRadius.circular(24.0)
    );
    var deselectedDecoration = BoxDecoration(
    );

    var selectedInputStyle = Theme.of(context).textTheme.title.copyWith(
        color: Colors.white, fontSize: 14);
    var deselectedInputStyle = Theme.of(context).textTheme.subtitle.copyWith(
        fontSize: 12);


    return Scaffold(
      appBar: AppBar(
          title: Text("Class Excos", textAlign: TextAlign.center),
          elevation: 0.0),
      body: Container(
        margin: EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              gap2x,
              Material(
                borderRadius: BorderRadius.circular(24.0),
                elevation: 4.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selected = 0;
                          });},
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.0),
                            child: Text("COURSE REPS", style: selected == 0 ? selectedInputStyle : deselectedInputStyle, ), decoration: selected == 0 ? selectedDecoration : deselectedDecoration),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selected = 1;
                          });},
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.0), child: Text("CLASS EXECUTIVE", style: selected == 1 ? selectedInputStyle : deselectedInputStyle),
                            decoration: selected == 1 ? selectedDecoration : deselectedDecoration),
                      ),
                    )
                  ],
                ),
              ),

              gap2x,
              Expanded(
                  child: ExcoUserScreen(excoList[selected])
              )
            ],
          ),



          /*StreamBuilder<QuerySnapshot>(
            stream: EventDAO.queryEventsByType(eventType),
              builder: (context, snapshot){

                if(snapshot.hasData){
                  events.clear();

                  if(snapshot.data.documents.isEmpty){
                    return Center(child: Text("Nothing here..."));
                  }

                  snapshot.data.documents.forEach((doc) => events.add(EventDTO.fromJson(doc.data)));

                  events.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));

                  return  ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return EventListItemUser(events[index], onTap: (event){
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                              builder: (context) => EventDetailsScreen(event: event,)));
                        });
                      });
                }

                if(snapshot.hasError){
                  return Center(child: Text("Error fetching data, please check your network"));
                }

                return Loading();
              })*/

      )
    );


  }
}
