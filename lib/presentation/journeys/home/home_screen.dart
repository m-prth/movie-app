import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/di/get_it_di.dart';
import 'package:movie_app/presentation/bloc/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:movie_app/presentation/bloc/movie_carousel/movie_carousel_cubit.dart';
import 'package:movie_app/presentation/bloc/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:movie_app/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/journeys/home/movie_carousel/movie_carousel_widget.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_tabbed_widget.dart';
import 'package:movie_app/presentation/journeys/navigation_drawer/navigation_drawer.dart';

import '../../widgets/app_error_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselCubit movieCarouselCubit;
  late MovieBackdropCubit movieBackdropCubit;
  late MovieTabbedCubit movieTabbedCubit;
  late SearchMovieCubit searchMovieCubit;

  @override
  void initState() {
    super.initState();
    movieCarouselCubit = getItInstance<MovieCarouselCubit>();
    movieBackdropCubit = movieCarouselCubit.movieBackdropCubit;
    movieTabbedCubit = getItInstance<MovieTabbedCubit>();
    movieCarouselCubit.loadCarousel();
    searchMovieCubit = getItInstance<SearchMovieCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselCubit.close();
    movieBackdropCubit.close();
    movieTabbedCubit.close();
    searchMovieCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCarouselCubit,
        ),
        BlocProvider(
          create: (context) => movieBackdropCubit,
        ),
        BlocProvider(
          create: (context) => movieTabbedCubit,
        ),
        BlocProvider(
          create: (context) => searchMovieCubit,
        )
      ],
      child: Scaffold(
          drawer: NavigationDrawer(),
          body: BlocBuilder<MovieCarouselCubit, MovieCarouselState>(
            builder: (context, state) {
              if (state is MovieCarouselLoaded) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.6,
                      child: MovieCarouselWidget(
                        movies: state.movies,
                        defaultIndex: state.defaultIndex,
                      ),
                    ),
                    FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 0.4,
                      child: MovieTabbedWidget(),
                    ),
                  ],
                );
              } else if (state is MovieCarouselError) {
                return AppErrorWidget(
                  onPressed: () => movieCarouselCubit.loadCarousel(),
                  appErrorType: state.appErrorType,
                );
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
