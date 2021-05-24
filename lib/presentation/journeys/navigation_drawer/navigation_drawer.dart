import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/journeys/navigation_drawer/navigation_expanded_list_item.dart';
import 'package:movie_app/presentation/journeys/navigation_drawer/navigation_list_item.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

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
            title: 'Favourite Movies',
            onPressed: () {},
          ),
          NavigationExpandedListItem(
            title: 'Language',
            onPressed: () {},
            children: ['English', 'Spanish'],
          ),
          NavigationListItem(
            title: 'Feedback',
            onPressed: () {},
          ),
          NavigationListItem(
            title: 'About',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
