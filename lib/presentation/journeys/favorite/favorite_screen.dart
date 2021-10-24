import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/di/get_it_di.dart';
import 'package:movie_app/presentation/bloc/favorite/favorite_cubit.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';

import 'favorite_movie_grid_view.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteCubit _favoriteCubit;

  @override
  void initState() {
    super.initState();
    _favoriteCubit = getItInstance<FavoriteCubit>();
    _favoriteCubit.loadFavoriteMovie();
  }

  @override
  void dispose() {
    super.dispose();
    _favoriteCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.favoriteMovies.t(context)),
      ),
      body: BlocProvider.value(
        value: _favoriteCubit,
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteMoviesLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Text(
                    TranslationConstants.noFavoriteMovies.t(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              }
              return FavoriteMovieGridView(movies: state.movies);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
