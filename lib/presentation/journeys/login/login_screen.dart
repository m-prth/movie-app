import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/presentation/journeys/login/login_form.dart';
import 'package:movie_app/presentation/widgets/logo.dart';
import 'package:movie_app/common/extensions/size_extension.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_32.h),
              child: Logo(
                height: Sizes.dimen_12.h,
              ),
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
