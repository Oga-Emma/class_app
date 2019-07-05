import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:flutter/material.dart';

class PersonListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
              ),
              gap2x,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("User Name",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),),
                    Text("Post",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                  ],),
              ),
              gap2x,
              InkWell(
                onTap: (){},
                child: Container(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.add_call, size: 20, color: ColorUtils.primaryColor),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: ColorUtils.primaryColor)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
