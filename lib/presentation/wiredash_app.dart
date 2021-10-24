import 'package:flutter/material.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final navigatorkey;
  final Widget child;
  final String languageCode;

  const WiredashApp({
    Key key,
    @required this.navigatorkey,
    @required this.child,
    @required this.languageCode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'movie-app-flwmx5e',
      secret: 'hzfmxg2uahdcecw1v1rivmc0fvl1uu7v471qiwgn8anumj53',
      navigatorKey: navigatorkey,
      child: child,
      options: WiredashOptionsData(
        // showDebugFloatingEntryPoint: false,
        locale: Locale.fromSubtags(languageCode: languageCode),
      ),
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor: AppColor.vulcan,
        dividerColor: AppColor.vulcan,
      ),
    );
  }
}
