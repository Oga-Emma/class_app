import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/file_or_url.dart';
import 'package:class_app/model/post_dto.dart';
import 'package:class_app/model/short_user_info.dart';
import 'package:class_app/service/post_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/admin/select_course_dialog.dart';
import 'package:class_app/ui/auth/base_auth.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/helper_widgets/toast_helper.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/error_handler.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/widgets/profile_avatar.dart';
import 'package:class_app/ui/widgets/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class NewEditPostScreen extends StatefulWidget {
  NewEditPostScreen({this.post});
  PostDTO post;
  @override
  _NewEditPostScreenState createState() => _NewEditPostScreenState();
}

class _NewEditPostScreenState extends State<NewEditPostScreen>
    with BaseAuth, UISnackBarProvider, ErrorHandler {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController titleController;
  TextEditingController postController;

  List<FileOrUrl> filesOrUrls = [];
  PostDTO post;
  CourseDTO selectedCourse;

  @override
  void initState() {
    if (widget.post != null) {
      post = widget.post;

      filesOrUrls.addAll(post.medias.map((att) => FileOrUrl()
        ..url = att.content
        ..type = att.type));
    } else {
      post = PostDTO();
    }
    titleController = TextEditingController(text: post.heading);
    postController = TextEditingController(text: post.content);

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    postController.dispose();

    super.dispose();
  }

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.close),
          ),
//          iconTheme:
//              Theme.of(context).iconTheme.copyWith(color: Colors.grey[600]),
//          backgroundColor: Colors.white,
          title: Text("Create Post"),
          elevation: 2.0,
          actions: <Widget>[
            FlatButton(
                onPressed: saveChanges,
                child: Text(
                  "PUBLISH",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              EmptySpace(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ProfileAvatar(
                      url: post.user.isNull
                          ? appState.user.profilePicture
                          : post.user.profilePicture,
                      radius: 28.0,
                    ),
                    EmptySpace(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "${post.user.isNull ? appState.user.fullName : post.user.name}"),
                          EmptySpace(multiple: .5),
                          Row(
                            children: <Widget>[
//                              Container(
//                                padding: EdgeInsets.symmetric(horizontal: 4.0),
//                                decoration: BoxDecoration(
//                                  border: Border.all(
//                                      color: ColorUtils.primaryColor),
//                                  borderRadius: BorderRadius.circular(4.0),
//                                ),
//                                child: Row(
//                                  mainAxisSize: MainAxisSize.min,
//                                  children: <Widget>[
//                                    Icon(
//                                      Icons.settings,
//                                      size: 16,
//                                      color: Colors.grey,
//                                    ),
//                                    EmptySpace(multiple: .5),
//                                    DropdownButton(
//                                        icon: Icon(
//                                          Icons.arrow_drop_down,
//                                          size: 16,
//                                          color: Colors.grey,
//                                        ),
//                                        hint: Text('Category'),
//                                        underline: SizedBox(),
//                                        isDense: true,
//                                        items: [
//                                          'General',
//                                          'Urgent',
//                                          'Announcement'
//                                        ]
//                                            .map((it) => DropdownMenuItem(
//                                                    child: Text(
//                                                  it,
//                                                  style:
//                                                      TextStyle(fontSize: 12),
//                                                )))
//                                            .toList(),
//                                        onChanged: (value) {
//                                          print(value);
//                                        }),
//                                  ],
//                                ),
//                              ),
//                              EmptySpace(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorUtils.primaryColor),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: InkWell(
                                  onTap: showCourseChooser,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.folder_open,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      EmptySpace(multiple: .5),
                                      Text(
                                        post.course == null ||
                                                post.course.isEmpty
                                            ? 'Course'
                                            : post.course,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              EmptySpace(multiple: 2),
              Divider(thickness: 10),
              EmptySpace(multiple: 2),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: titleController,
                        decoration:
                            InputDecoration.collapsed(hintText: "Heading"),
                        maxLines: 2,
                      ),
                      Divider(),
                      Expanded(
                        child: TextFormField(
                          controller: postController,
                          decoration: InputDecoration.collapsed(
                              hintText: "What is on your mind?"),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              EmptySpace(),
              getAttachments(),
              attachmentButton(
                  'Select Photo/Camera',
                  Icon(Icons.photo, color: ColorUtils.primaryColor),
                  selectImageCamera),
//            attachmentButton('Document',
//                Icon(Icons.folder_open, color: ColorUtils.primaryColor)),
//            attachmentButton(
//                'Pdf', Icon(Icons.picture_as_pdf, color: Colors.red)),
            ],
          ),
        ));
  }

  getAttachments() {
    return Visibility(
      visible: filesOrUrls.isNotEmpty,
      child: Container(
        height: 150,
        child: ListView.builder(
            itemCount: filesOrUrls.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 140,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey[300])),
                        child: filesOrUrls[index].asset != null
                            ? AssetThumb(
                                asset: filesOrUrls[index].asset,
                                width: 140,
                                height: 180,
                              )
                            : CachedNetworkImage(
                                imageUrl: filesOrUrls[index].url,
                                fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black26,
                          child: InkWell(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              onTap: () {
                                setState(() {
                                  filesOrUrls.removeAt(index);
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget attachmentButton(String text, Icon icon, Function() onTap) {
    return Column(
      children: <Widget>[
        Divider(),
        ListTile(
          onTap: onTap,
          title: Text(text),
          dense: true,
          leading: icon,
          trailing: Icon(Icons.add),
        ),
      ],
    );
  }

  Future<void> selectImageCamera() async {
    List<Asset> resultList = [];
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: true,
        maxImages: 5 - filesOrUrls.length,
      );
    } on Exception catch (e) {
//      error = e.message;
      print(e);
    }

    if (!mounted) return;

    setState(() {
      filesOrUrls.addAll(resultList.map((res) => FileOrUrl()
        ..asset = res
        ..type = MediaTypes.IMAGE));
//      images = resultList;
//      if (error == null) _error = 'No Error Dectected';
    });
  }

  showCourseChooser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SelectCourse(
            onCourseSelected: (course) {
              selectedCourse = course;
              post.course = selectedCourse.code;
              setState(() {});
//            courseController.text = selectedCourse.code;
              Navigator.pop(context);
            },
          );
        });
  }

  saveChanges() async {
    try {
      post.heading = titleController.text;
      post.content = postController.text;

      if (post.content.isEmpty && filesOrUrls.isEmpty) {
//      show error
//      showInSnackBar("No content or meadia");
        showErrorToast("No content or meadia");

        return;
      }

      showLoadingSnackBar();
      print(post.toMap());

      for (int i = 0; i < filesOrUrls.length; i++) {
        if (filesOrUrls[i].file != null || filesOrUrls[i].asset != null) {
          String url = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => UploadImage(
                    filesOrUrls[i].file,
                    "post/${post.id}/media$i",
                    "Uploading media ${i + 1}",
                    asset: filesOrUrls[i].asset,
                  ));
          if (url != null && url.isNotEmpty) {
            filesOrUrls[i].url = url;
          }
        }
      }

      if (post.user == null || post.user.isNull) {
        post.user = ShortUserInfo.fromUser(appState.user);
      }

      post.medias = filesOrUrls
          .map((data) => Media(data.type, content: data.url))
          .toList();

      post.group =
          "${appState.department.departmentCode}-${appState.department.entryYear}"
              .toLowerCase();

      if (selectedCourse != null) {
        post.course = selectedCourse.code;
      }

      await PostDAO.savePost(post);
      showSuccessToast('Saved');

      Navigator.pop(context);
    } catch (err) {
      var msg = getErrorMessage(err);
      showInSnackBar(msg);
    }

//    showLoading();
  }
}
