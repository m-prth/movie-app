import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/screenutil/screen_util.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

class MovieAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svgs/menu.svg',
              height: Sizes.dimen_12.h,
            ),
          ),
          Expanded(
            child: const Logo(
              height: Sizes.dimen_14,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: Sizes.dimen_12.h,
              ))
        ],
      ),
    );
  }
}
