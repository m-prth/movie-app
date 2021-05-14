import 'package:flutter/material.dart';
import 'package:movie_app/common/extensions/size_extension.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({Key key, @required this.height})
      : assert(height != null, "height must not be null"),
        assert(height > 0, 'Height should be greater than 0');

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pngs/logo.png',
      color: Colors.white,
      height: height.h,
    );
  }
}
