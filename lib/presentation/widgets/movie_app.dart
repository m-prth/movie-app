import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/screenutil/screen_util.dart';
import 'package:movie_app/di/get_it_di.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/bloc/language/language_bloc.dart';
import 'package:movie_app/presentation/journeys/home/home_screen.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/presentation/wiredash_app.dart';

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  LanguageBloc _languageBloc;
  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return WiredashApp(
              navigatorkey: _navigatorKey,
              languageCode: state.locale.languageCode,
              child: MaterialApp(
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Movie App',
                theme: ThemeData(
                  unselectedWidgetColor: AppColor.violet,
                  primaryColor: AppColor.vulcan,
                  accentColor: AppColor.royalBlue,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: AppBarTheme(elevation: 0),
                ),
                supportedLocales:
                    Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                home: HomeScreen(), //13:34
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
