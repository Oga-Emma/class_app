import 'package:class_app/model/comment_dto.dart';
import 'package:class_app/model/user_dto.dart';
import 'package:class_app/service/user_dao.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/date_helper.dart';
import 'package:class_app/ui/widgets/profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentListItem extends StatelessWidget {
  CommentListItem(this.comment);
  CommentDTO comment;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDTO>(
        future: UserDAO.getUser(comment.posterId),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            comment.user = snapshot.data;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProfileAvatar(
                  radius: 20,
                  url: comment.user.profilePicture,
                ),
                EmptySpace(),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      color: ColorUtils.primaryColor.withOpacity(0.1),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${comment.user.fullName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 14)),
                          EmptySpace(multiple: 0.5),
                          Text("${comment.comment}"),
                          EmptySpace(),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              Text(
                                "${getPostTime((comment.dateCreated as Timestamp).toDate())}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
