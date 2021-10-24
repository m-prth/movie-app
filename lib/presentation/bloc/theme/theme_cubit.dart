import 'package:bloc/bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_preffered_theme.dart';
import 'package:movie_app/domain/usecases/update_theme.dart';

enum Themes { light, dark }

class ThemeCubit extends Cubit<Themes> {
  final GetPreferredTheme getPrefferedTheme;
  final UpdateTheme updateTheme;

  ThemeCubit({
    @required this.getPrefferedTheme,
    @required this.updateTheme,
  }) : super(Themes.dark);

  Future<void> toggleTheme() async {
    await updateTheme(state == Themes.dark ? 'light' : 'dark');
    loadPreferredTheme();
  }

  void loadPreferredTheme() async {
    final response = await getPrefferedTheme(NoParams());
    emit(
      response.fold(
        (l) => Themes.dark,
        (r) => r == 'dark' ? Themes.dark : Themes.light,
      ),
    );
  }
}
