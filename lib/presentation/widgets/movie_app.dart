import 'package:flutter/material.dart';
import 'package:movie_app/common/screenutil/screen_util.dart';
import 'package:movie_app/presentation/journeys/home/home_screen.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primaryColor: AppColor.vulcan,
        accentColor: AppColor.royalBlue,
        scaffoldBackgroundColor: AppColor.vulcan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: AppBarTheme(elevation: 0),
      ),
      home: HomeScreen(), //13:34
    );
  }
}
