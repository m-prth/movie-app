import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';

import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/themes/app_color.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final Function onPressed;
  final List<String> children;

  const NavigationExpandedListItem({
    Key key,
    @required this.title,
    @required this.onPressed,
    @required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2,
            )
          ],
        ),
        child: ExpansionTile(
          collapsedIconColor: AppColor.violet,
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          children: [
            for (int i = 0; i < children.length; i++)
              NavigationSubListItem(
                title: children[i],
                onPressed: () {},
              )
          ],
        ),
      ),
    );
  }
}

class NavigationSubListItem extends StatelessWidget {
  final String title;
  final Function onPressed;

  const NavigationSubListItem({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2,
            )
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
