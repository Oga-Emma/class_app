import 'package:class_app/model/post_dto.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/info_screen/post_details_screen.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:class_app/ui/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  PostListItem(this.post);
  PostDTO post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0, bottom: 4.0),
      child: Material(
//          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PostDetailsScreen()));
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${post.getCategory()}",
                              style: TextStyle(fontSize: 12.0)),
                          EmptySpace(),
                          Text(
                            '${post.heading}',
                            style: Theme.of(context).textTheme.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          EmptySpace(),
                          Expanded(
                            child: Text(
                              '${post.content}',
                              style: TextStyle(fontSize: 12),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16.0),
                      height: 100,
                      width: 80,
                      color: Colors.grey[300],
                    )
                  ],
                ),
              ),
//              SizedBox(height: 10),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        ProfileAvatar(
                          url: post.user.profilePicture,
                        ),
                        EmptySpace(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${post.user.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(fontSize: 12),
                              ),
                              Text(
                                '${post.dateModified.toDate()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  EmptySpace(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.message,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${post.commentCount}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
