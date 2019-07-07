import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/exco_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/service/exco_dao.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectExco extends StatefulWidget {
  SelectExco({@required this.onExcoSelected});
  final Function(ExcoDTO exco) onExcoSelected;


  @override
  _SelectExcoState createState() => _SelectExcoState();
}

class _SelectExcoState extends State<SelectExco> {

  List<ExcoDTO> excos = [];

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("SELECT COURSE REP", style: Theme.of(context).textTheme.subtitle,),
      content: Container(
        height: MediaQuery.of(context).size.width,
        width: 300.0, // Change as per your requirement
        child: StreamBuilder<QuerySnapshot>(
            stream: ExcoDAO.fetchAllExcos(),
            builder: (context, stream){
              if(stream.hasData){
                excos.clear();
                stream.data.documents.forEach((doc){
                  excos.add(ExcoDTO.fromJson(doc.data));
                });
                return ListView.builder(
                    itemCount: excos.length,
                    itemBuilder: (context, index) {
                      var exco = excos[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("${exco.firstName} ${exco.lastName}"),
                            subtitle: Text(exco.post),
                              onTap: (){
                                widget.onExcoSelected(exco);
                              }
                          ),
                          Container(height: 1,
                              color: Colors.grey.withOpacity(0.4),
                          margin: EdgeInsets.symmetric(vertical: 16.0),)
                        ],
                      );
                    }
                );
              }

              if(stream.hasError){
                return Center(child: Text("Error fetcing data, please try again"));
              }

              return Loading();
            })
      ),
    );
  }
}