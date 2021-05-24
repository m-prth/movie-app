import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';

class MovieDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
      builder: (context, state) {
        if (state is MovieBackdropChanged) {
          return Text(
            state.movie.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headline6,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
