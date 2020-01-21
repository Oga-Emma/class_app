import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/service/event_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/list_items/course_admin_list_item.dart';
import 'package:class_app/ui/list_items/event_list_item_admin.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Events extends StatelessWidget {

  final List<EventDTO> events = [];

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: EventDAO.fetchAllEvents(appState.appInfo),
            builder: (context, stream){
          if(stream.hasData){
            events.clear();
            stream.data.documents.forEach((doc){
              events.add(EventDTO.fromJson(doc.data));
            });
            return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) => EventListItemAdmin(events[index], onTap: (course){

                },));
          }

          if(stream.hasError){
            return Center(child: Text("Error fetcing data, please try again"));
          }

          return Loading();
        })
    );
  }
}
