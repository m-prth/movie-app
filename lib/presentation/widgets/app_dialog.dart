import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/widgets/button.dart';

class AppDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Widget image;

  const AppDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.vulcan,
      elevation: Sizes.dimen_32,
      insetPadding: EdgeInsets.all(Sizes.dimen_32.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_8.w),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: Sizes.dimen_4.h,
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: Sizes.dimen_16,
            color: AppColor.vulcan,
          )
        ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.t(context),
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
              child: Text(
                description.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            if (image != null) image,
            Button(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: TranslationConstants.okay,
            ),
          ],
        ),
      ),
    );
  }
}
