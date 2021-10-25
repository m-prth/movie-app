import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';

import 'package:movie_app/presentation/bloc/language/language_cubit.dart';
import 'package:movie_app/presentation/bloc/login/login_cubit.dart';
import 'package:movie_app/presentation/bloc/theme/theme_cubit.dart';

import 'package:movie_app/presentation/journeys/navigation_drawer/navigation_expanded_list_item.dart';
import 'package:movie_app/presentation/journeys/navigation_drawer/navigation_list_item.dart';
import 'package:movie_app/presentation/themes/app_color.dart';

import 'package:movie_app/presentation/widgets/app_dialog.dart';
import 'package:movie_app/presentation/widgets/logo.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:wiredash/wiredash.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4)
      ]),
      width: Sizes.dimen_300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Sizes.dimen_8.h,
              bottom: Sizes.dimen_18.h,
              left: Sizes.dimen_8.h,
              right: Sizes.dimen_8.h,
            ),
            child: Logo(
              height: Sizes.dimen_20.h,
            ),
          ),
          NavigationListItem(
            title: TranslationConstants.favoriteMovies.t(context),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteList.favorite);
            },
          ),
          NavigationExpandedListItem(
            title: TranslationConstants.language.t(context),
            onPressed: (index) {
              BlocProvider.of<LanguageCubit>(context)
                  .toggleLanguage(Languages.languages[index]);
            },
            children: Languages.languages.map((e) => e.value).toList(),
          ),
          //comments
          NavigationListItem(
            title: TranslationConstants.feedback.t(context),
            onPressed: () {
              Navigator.of(context).pop();
              Wiredash.of(context).show();
            },
          ),
          NavigationListItem(
            title: TranslationConstants.about.t(context),
            onPressed: () {
              Navigator.of(context).pop();
              _showDialog(context);
            },
          ),
          BlocListener<LoginCubit, LoginState>(
            listenWhen: (previous, current) => current is LogoutSuccess,
            listener: (context, state) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RouteList.initial, (route) => false);
            },
            child: NavigationListItem(
              title: TranslationConstants.logout.t(context),
              onPressed: () {
                BlocProvider.of<LoginCubit>(context).logout();
              },
            ),
          ),
          Spacer(),
          BlocBuilder<ThemeCubit, Themes>(builder: (context, theme) {
            return Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                icon: Icon(
                  theme == Themes.dark
                      ? Icons.brightness_4_sharp
                      : Icons.brightness_7_sharp,
                  color: context.read<ThemeCubit>().state == Themes.dark
                      ? Colors.white
                      : AppColor.vulcan,
                  size: Sizes.dimen_40.w,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AppDialog(
          title: TranslationConstants.about,
          description: TranslationConstants.aboutDescription,
          buttonText: TranslationConstants.okay,
          image: Image.asset(
            'assets/pngs/tmdb_logo.png',
            height: Sizes.dimen_32.h,
          ),
        );
      },
    );
  }
}
