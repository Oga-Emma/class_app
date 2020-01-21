import 'package:class_app/model/event_dto.dart';
import 'package:class_app/service/event_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/event/event_details_screen.dart';
import 'package:class_app/ui/list_items/event_list_item_user.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen(this.eventType);
  final String eventType;
  final List<EventDTO> events = [];

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(eventType, textAlign: TextAlign.center),
          elevation: 0.0),
      body: Container(
          color: Colors.grey[200],
          child: StreamBuilder<QuerySnapshot>(
            stream: EventDAO.queryEventsByType(appState.appInfo, eventType),
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
              }))
    );


  }
}
