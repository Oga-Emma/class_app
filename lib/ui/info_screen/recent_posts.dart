import 'package:class_app/ui/info_screen/post_details_screen.dart';
import 'package:class_app/ui/list_items/post_list_item.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:flutter/material.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return PostListItem();
          }),
    );
  }
}
