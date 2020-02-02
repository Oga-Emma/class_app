import 'package:cached_network_image/cached_network_image.dart';
import 'package:class_app/model/post_dto.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/helper_widgets/toast_helper.dart';
import 'package:class_app/ui/info_screen/post_details_screen.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:class_app/ui/utils/share_utils.dart';
import 'package:class_app/ui/widgets/profile_avatar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class PostListItem extends StatefulWidget {
  PostListItem(this.post);
  PostDTO post;

  @override
  _PostListItemState createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0, bottom: 4.0),
      child: Material(
//          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostDetailsScreen(widget.post)));
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
//          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${widget.post.getCategory()}",
                            style: TextStyle(fontSize: 12.0)),
                        EmptySpace(),
                        Text(
                          '${widget.post.heading}',
                          style: Theme.of(context).textTheme.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        EmptySpace(),
                        Text(
                          '${widget.post.content}' * 10,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12),
                          maxLines: isExpanded ? null : 4,
                          overflow: isExpanded ? null : TextOverflow.ellipsis,
                        ),
                        EmptySpace(),
                        SizedBox(
                          height: 24,
                          width: double.maxFinite,
                          child: OutlineButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                isExpanded ? 'Close' : 'Read more...',
                                style: Theme.of(context).textTheme.caption,
                              )),
                        )
                      ],
                    ),
                  ),
                  getImage(widget.post.medias),
                ],
              ),
//              SizedBox(height: 10),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        ProfileAvatar(
                          url: widget.post.user.profilePicture,
                        ),
                        EmptySpace(),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${widget.post.user.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(fontSize: 12),
                              ),
                              Text(
                                '${widget.post.dateModified.toDate()}',
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
                    onPressed: () {
                      ShareUtils.SharePost(widget.post);
                    },
                    icon: Icon(
                      Icons.share,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        EvaIcons.messageCircle,
                        size: 20,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${widget.post.commentCount}',
                        style: TextStyle(color: Colors.grey),
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

  getImage(List<Media> medias) {
//    medias.forEach((el) => print(el.toMap()));
    var imageMedia = medias.where((el) => el.type == MediaTypes.IMAGE).toList();

    if (imageMedia.isEmpty) {
      return SizedBox();
    }

    return Visibility(
      visible: imageMedia.isNotEmpty,
      child: Container(
        margin: EdgeInsets.only(left: 16.0),
        height: 100,
        width: 100,
        color: Colors.grey[300],
        child: CachedNetworkImage(
            imageUrl: imageMedia[0].content, fit: BoxFit.cover),
      ),
    );
  }
}
