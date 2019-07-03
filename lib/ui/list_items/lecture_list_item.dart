import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:flutter/material.dart';

class LectureListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "08:00",
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12.0),
              ),
              Text(
                "10:00",
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(fontSize: 12.0),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                      width: 1.0,
                      height: double.infinity,
                      color: Colors.grey.withOpacity(0.5)),
                ),
                Icon(Icons.check_box_outline_blank,
                    size: 16.0,
                    color: Theme.of(context).primaryColor),
                Expanded(
                  child: Container(
                      width: 1.0,
                      height: double.infinity,
                      color: Colors.grey.withOpacity(0.5)),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorUtils.accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(16.0)
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "COS 205",
                          style: Theme.of(context).textTheme.title.copyWith(
                              color: ColorUtils.primaryColor),
                        ),
                      ],
                    ),
                    gap,
                    Expanded(
                      child: Text(
                        "Introduction to Computer Science",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(
                            color: Colors.black
                                .withOpacity(0.5)),
                      ),
                    ),
                    gap,
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.near_me,
                          size: 18,
                          color: Theme.of(context).accentColor,
                        ),
                        gap,
                        Expanded(
                          child: Text(
                            "Room 412, Abuja Building, Room 412, Abuja Building, Room 412, Abuja Building",
                            style: Theme.of(context)
                                .textTheme
                                .caption,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      ],
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ))
        ],
      ),
    );
  }
}
