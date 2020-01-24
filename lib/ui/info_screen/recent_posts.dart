import 'package:class_app/model/post_dto.dart';
import 'package:class_app/ui/info_screen/post_details_screen.dart';
import 'package:class_app/ui/list_items/post_list_item.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostsList extends StatefulWidget {
  PostsList(this.documents);
  List<DocumentSnapshot> documents;

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: widget.documents.length,
          itemBuilder: (context, index) {
            return PostListItem(PostDTO.fromMap(widget.documents[index].data)..id = widget.documents[index].documentID);
          }),
    );
  }
}
