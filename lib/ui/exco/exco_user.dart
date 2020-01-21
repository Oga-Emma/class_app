import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/exco_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/service/event_dao.dart';
import 'package:class_app/service/exco_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/list_items/course_admin_list_item.dart';
import 'package:class_app/ui/list_items/event_list_item_admin.dart';
import 'package:class_app/ui/list_items/exco_list_item.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'exco_preview_dialog.dart';

class ExcoUserScreen extends StatelessWidget {
  ExcoUserScreen(this.type);
  final String type;

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: ExcoDAO.fetchAllExcos(appState.appInfo),
            builder: (context, stream) {
              if (stream.hasData) {
                List<ExcoDTO> excos = [];
                stream.data.documents.forEach((doc) {
                  excos.add(ExcoDTO.fromJson(doc.data));
                });

                excos = excos.where((ex) => ex.type == type).toList();

                return excos.isEmpty
                    ? Center(child: Text("Nothing here..."))
                    : ListView.builder(
                        itemCount: excos.length,
                        itemBuilder: (context, index) => ExcoListItem(
                              excos[index],
                              onTap: (exco) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        ExcoPreviewDialog(exco.id));
                              },
                            ));
              }

              if (stream.hasError) {
                return Center(
                    child: Text("Error fetcing data, please try again"));
              }

              return Loading();
            }));
  }
}
