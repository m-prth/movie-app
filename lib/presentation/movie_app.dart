import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/screenutil/screen_util.dart';
import 'package:movie_app/di/get_it_di.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/bloc/language/language_cubit.dart';
import 'package:movie_app/presentation/bloc/loading/loading_cubit.dart';
import 'package:movie_app/presentation/bloc/login/login_cubit.dart';
import 'package:movie_app/presentation/bloc/theme/theme_cubit.dart';
import 'package:movie_app/presentation/fade_page_route_builder.dart';
import 'package:movie_app/presentation/journeys/loading/loading_screen.dart';

import 'package:movie_app/presentation/routes.dart';
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
  LanguageCubit _languageCubit;
  LoginCubit _loginCubit;
  LoadingCubit _loadingCubit;
  ThemeCubit _themeCubit;
  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();
    _loginCubit = getItInstance<LoginCubit>();
    _loadingCubit = getItInstance<LoadingCubit>();
    _themeCubit = getItInstance<ThemeCubit>();
    _themeCubit.loadPreferredTheme();
  }

  @override
  void dispose() {
    _languageCubit?.close();
    _loginCubit?.close();
    _loadingCubit?.close();
    _themeCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(
          value: _languageCubit,
        ),
        BlocProvider<LoginCubit>.value(
          value: _loginCubit,
        ),
        BlocProvider<LoadingCubit>.value(
          value: _loadingCubit,
        ),
        BlocProvider<ThemeCubit>.value(
          value: _themeCubit,
        ),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        builder: (context, state) {
          return BlocBuilder<LanguageCubit, Locale>(builder: (context, locale) {
            return WiredashApp(
              navigatorkey: _navigatorKey,
              languageCode: locale.languageCode,
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
                locale: locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                builder: (context, child) {
                  return LoadingScreen(
                    screen: child,
                  );
                },
                initialRoute: RouteList.initial,
                onGenerateRoute: (RouteSettings settings) {
                  final routes = Routes.getRoutes(settings);
                  final WidgetBuilder builder = routes[settings.name];
                  return FadePageRouteBuilder(
                    builder: builder,
                    settings: settings,
                  );
                },
              ),
            );
          });
        },
      ),
    );
  }
}
