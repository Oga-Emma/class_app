import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({this.url = "", this.file, this.radius = 24.0});
  String url;
  File file;
  double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CircleAvatar(
        backgroundColor: Colors.grey[300],
        radius: radius,
        child: file != null
            ? Image.file(file, fit: BoxFit.cover)
            : (url == null || url.isEmpty)
                ? SvgPicture.asset(
                    "assets/svg/user_avatar.svg",
                    height: radius,
                    width: radius,
                    color: Colors.grey[600],
                  )
                : CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
      ),
    );
  }
}
