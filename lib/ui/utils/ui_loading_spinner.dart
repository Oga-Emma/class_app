import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    Key key,
    this.color,
    this.size,
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitRing(color: ColorUtils.primaryColor.withOpacity(.4), lineWidth: 4.0,)
      /*child: SpinKitFadingCube(
        // color: color ?? kPrimaryColor,
        size: size ?? 28.0,
        itemBuilder: (_, int i) {
          if (color != null) {
            return _box(color);
          }
          return i.isEven
              ? _box(ColorUtils.colorAccent.withOpacity(.4))
              : _box(ColorUtils.colorPrimary);
        },
      ),*/
    );
  }

  Widget _box(Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color),
    );
  }
}
