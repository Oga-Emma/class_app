import 'package:class_app/model/exco_dto.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ExcoListItem extends StatelessWidget {
  ExcoListItem(this.exco, {this.onTap});
  final ExcoDTO exco;
  final Function(ExcoDTO exco) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        borderRadius: BorderRadius.circular(4.0),
        elevation: 2.0,
        child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap(exco);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                  backgroundImage: exco.imageUrl.isEmpty
                      ? AssetImage("assets/img/user.png")
                      : CachedNetworkImageProvider(exco.imageUrl),
                ),
                gap2x,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${exco.lastName} ${exco.firstName} ${exco.otherName}"
                            .toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        "${exco.post}".toUpperCase(),
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                gap2x,
                InkWell(
                  onTap: () async {
                    if (exco.phone.isNotEmpty) {
                      var url = "tel:${exco.phone}";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
//                  throw 'Could not launch $url';
                        showShortToast("Could not make call");
                      }
                    } else {
                      showShortToast("Phone number not available");
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Icon(Icons.add_call,
                        size: 14, color: ColorUtils.primaryColor),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: ColorUtils.primaryColor)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
