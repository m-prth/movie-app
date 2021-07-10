import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/journeys/login/label_field_widget.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _userNameController, _passwordController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController?.clear();
    _passwordController?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_32.w, vertical: Sizes.dimen_24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.dimen_8.h),
              child: Text(
                TranslationConstants.loginToMovieApp.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            LabelFieldWidget(
              controller: _userNameController,
              hintText: TranslationConstants.enterTMDbUsername.t(context),
              isPasswordField: false,
              label: TranslationConstants.username.t(context),
            ),
            LabelFieldWidget(
              controller: _passwordController,
              hintText: TranslationConstants.enterPassword.t(context),
              isPasswordField: true,
              label: TranslationConstants.password.t(context),
            ),
          ],
        ),
      ),
    );
  }
}
