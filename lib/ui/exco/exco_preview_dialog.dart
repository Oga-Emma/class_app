import 'package:cached_network_image/cached_network_image.dart';
import 'package:class_app/model/exco_dto.dart';
import 'package:class_app/service/exco_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ExcoPreviewDialog extends StatelessWidget {
  ExcoPreviewDialog(this.id);
  final String id;

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      content: Container(
        width: double.maxFinite,
        child: FutureBuilder<DocumentSnapshot>(
          future: ExcoDAO.getExco(appState.appInfo, id),
            builder: (context, snapshot){
          if(snapshot.hasData){
            var exco = ExcoDTO.fromJson(snapshot.data.data);

            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    backgroundImage: exco.imageUrl.isEmpty ? AssetImage("assets/img/user.png") :
                    CachedNetworkImageProvider(exco.imageUrl),
                  ),
                  gap2x,
                  Text("${exco.firstName} ${exco.lastName} ${exco.otherName} (${exco.gender[0]})",
                  style: Theme.of(context).textTheme.title,),
                  Text("${exco.post}",
                  style: Theme.of(context).textTheme.caption,),
                  gap2x,
                  RaisedButton(onPressed: () async {
                    if(exco.phone.isNotEmpty){
                      var url = "tel:${exco.phone}";
                      if (await canLaunch(url)) {
                    await launch(url);
                    } else {
//                  throw 'Could not launch $url';
                    showShortToast("Could not make call");
                    }
                    }else{
                    showShortToast("Phone number not available");
                    }
                  },
                    color: ColorUtils.primaryColor,
                    child: Text("CALL", style: TextStyle(color: Colors.white),),
                  shape: StadiumBorder(),)
                ],
              ),
            );
          }

          if(snapshot.hasError){
            return Center(child: Text("error message"));
          }

          return Container(
              height: 50,
              child: Loading());
        }),
      ),
    );
  }
}
