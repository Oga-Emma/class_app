import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:class_app/model/comment_dto.dart';
import 'package:class_app/model/post_dto.dart';
import 'package:class_app/service/post_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/helper_widgets/toast_helper.dart';
import 'package:class_app/ui/info_screen/new_post_screen.dart';
import 'package:class_app/ui/list_items/comment_list_item.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/date_helper.dart';
import 'package:class_app/ui/utils/loading_spinner.dart';
import 'package:class_app/ui/widgets/profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen(this.post);
  PostDTO post;

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    var textStyle = Theme.of(context).textTheme;

    var imageMedia =
        post.medias.where((el) => el.type == MediaTypes.IMAGE).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Post"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
            Visibility(
                visible:
                    appState.isSuperAdmin || post.user.id == appState.user.id,
                child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Router.gotoWidget(NewEditPostScreen(post: post), context);
                    })),
            Visibility(
                visible:
                    appState.isSuperAdmin || post.user.id == appState.user.id,
                child: IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      deletePost(post, context);
                    })),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${post.getCategory()}',
                          style: textStyle.body2.copyWith(fontSize: 12.0)),
                      EmptySpace(),
                      Text('${post.content}', style: textStyle.headline),
                      SizedBox(
                          width: 70,
                          child: Divider(
                            color: ColorUtils.primaryColor,
                            thickness: 1.5,
                          )),
                      EmptySpace(),
                      Visibility(
                          visible: imageMedia.isNotEmpty,
                          child: getMedia(imageMedia)),
                      EmptySpace(),
                      Row(
                        children: <Widget>[
                          ProfileAvatar(
                              radius: 20, url: post.user.profilePicture),
                          EmptySpace(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${post.user.name}'),
                                EmptySpace(multiple: 0.5),
                                Text(
                                    '${getPostTime(post.datePublished.toDate())}',
                                    style: textStyle.caption),
                              ],
                            ),
                          ),
                          FlatButton.icon(
                              onPressed: () => showComments(context),
                              icon: Icon(Icons.comment,
                                  color: Colors.grey, size: 16.0),
                              label: Text("${post.commentCount}"))
                        ],
                      ),
                      EmptySpace(),
                      Text(
                        "${post.content}",
                        style: TextStyle(height: 1.5),
                      ),
                      EmptySpace(multiple: 10)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  child: InkWell(
                    onTap: () => showComments(context),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        margin: EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Text('Say something'),
                        )),
                  ),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, -1),
                        blurRadius: 10,
                        spreadRadius: .8),
                  ]),
                ))
          ],
        ));
  }

  void showComments(context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return PostComments(post);
        },
      ),
    );
  }

  getMedia(List<Media> medias) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
          height: 200,
          width: double.maxFinite,
          color: Colors.grey[300],
          child: Carousel(
            images: medias
                .map((md) => CachedNetworkImage(
                      placeholder: (context, url) {
                        return Center(child: CircularProgressIndicator());
                      },
                      imageUrl: md.content,
                      fit: BoxFit.cover,
                    ))
                .toList(),

            /* [
            NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
            NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
            ExactAssetImage("assets/images/LaunchImage.jpg")
          ],*/

            autoplayDuration: Duration(seconds: 5),
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Colors.white,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.black26,
            borderRadius: true,
          )),
    );
  }

  Future<void> deletePost(PostDTO post, BuildContext context) async {
    bool delete = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Delete Post"),
              content: Text(
                  "Are you sure you want to delete this post? (Note: this action cannot be undone)"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('CANCEL')),
                FlatButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('DELETE')) ??
                    false,
              ],
            ));

    if (delete) {
      await PostDAO.deletePost(post);
      showSuccessToast('post deleted');
      Navigator.pop(context);
    }
  }
}

class PostComments extends StatefulWidget {
  PostComments(this.post);
  PostDTO post;

  @override
  _PostCommentsState createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  bool sending = false;
  TextEditingController commentController;

  @override
  void initState() {
    commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: 48),
        color: Colors.black26,
        child: Material(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('Comments (${widget.post.commentCount})',
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 18)),
                        ),
                        InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.close),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Observable.fromFuture(
                            PostDAO.getComments(widget.post.id)),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: <Widget>[
                                Expanded(
                                    child: loadCommentList(
                                        snapshot.data.documents)),
                                EmptySpace(multiple: 5)
                              ],
                            );
                          }

                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return Center(child: Text('Error occured'));
                          }

                          return LoadingSpinner();
                        }),
                  )
                ],
              )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 0.0),
                              margin: EdgeInsets.all(4.0),
                              child: TextField(
                                controller: commentController,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Say something..."),
                                minLines: 1,
                                maxLines: 5,
                              ))),
                      sending
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              height: 24,
                              width: 24,
                              child: LoadingSpinner())
                          : IconButton(
                              icon: Icon(Icons.send,
                                  color: ColorUtils.primaryColor),
                              onPressed: sendComment)
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, -1),
                        blurRadius: 10,
                        spreadRadius: .8),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendComment() async {
    String text = commentController.text;

    if (text != null && text.isNotEmpty) {
      setState(() {
        sending = true;
      });
      var comment = CommentDTO()
        ..comment = text
        ..posterId = appState.currentUser.uid;
      try {
        await PostDAO.saveComment(widget.post, comment);
        setState(() {
          sending = false;
        });
        commentController.text = '';
        widget.post.commentCount++;
      } catch (err) {
        print(err);
        showErrorToast('Error posting comment, try again');
        setState(() {
          sending = false;
        });
      }
    }
  }

  Widget loadCommentList(List<DocumentSnapshot> documents) {
    if (documents.isEmpty) {
      return Center(child: Text('No comment yet'));
    }

    return ListView.builder(
        reverse: true,
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return CommentListItem(CommentDTO.fromJson(documents[index].data)
            ..id = documents[index].documentID);
        });
  }
}
