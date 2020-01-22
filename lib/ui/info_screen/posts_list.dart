import 'package:class_app/ui/info_screen/post_details_screen.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:flutter/material.dart';

class RecentPosts extends StatefulWidget {
  @override
  _RecentPostsState createState() => _RecentPostsState();
}

class _RecentPostsState extends State<RecentPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                  top: 6.0, bottom: 4.0, left: 8.0, right: 8.0),
              child: Material(
                  shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostDetailsScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: borderRadius),
                            padding: EdgeInsets.all(8.0),
                            child: Text("EXAMS",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white)),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              'Update on CS8214 - Postponed to next week due to unforseen circumstances.',
                              style: Theme.of(context).textTheme.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                '10:40 AM',
                                style: Theme.of(context).textTheme.caption,
                              )),
                              Icon(
                                Icons.message,
                                size: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '10',
                                style: TextStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}
