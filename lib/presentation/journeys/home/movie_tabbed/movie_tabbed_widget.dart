import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/bloc/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_list_view_builder.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_tabbed_constants.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/tab_title_widget.dart';
import 'package:movie_app/presentation/journeys/loading/loading_circle.dart';
import 'package:movie_app/presentation/widgets/app_error_widget.dart';

class MovieTabbedWidget extends StatefulWidget {
  @override
  _MovieTabbedWidgetState createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget>
    with SingleTickerProviderStateMixin {
  MovieTabbedCubit get movieTabbedCubit =>
      BlocProvider.of<MovieTabbedCubit>(context);

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabbedCubit.movieTabChanged(currentTabIndex: currentTabIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedCubit, MovieTabbedState>(
        builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(top: Sizes.dimen_4.h),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var i = 0; i < MovieTabbedConstants.movieTabs.length; i++)
                  TabTitleWidget(
                    title: MovieTabbedConstants.movieTabs[i].title,
                    onTap: () => _onTabTapped(i),
                    isSelected: MovieTabbedConstants.movieTabs[i].index ==
                        state.currentTabIndex,
                  ),
              ],
            ),
            if (state is MovieTabChanged)
              state.movies.isEmpty
                  ? Expanded(
                      child: Center(
                          child: Text(
                        TranslationConstants.noMovies.t(context) ?? "No Movies",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                    )
                  : Expanded(
                      child: MovieListViewBuilder(movies: state.movies),
                    ),
            if (state is MovieTabLoadError)
              Expanded(
                child: AppErrorWidget(
                  appErrorType: state.errorType,
                  onPressed: () => movieTabbedCubit.movieTabChanged(
                    currentTabIndex: state.currentTabIndex,
                  ),
                ),
              ),
            if (state is MovieTabLoading)
              Expanded(
                child: Center(
                  child: LoadingCircle(
                    size: Sizes.dimen_100.w,
                  ),
                ),
              )
          ],
        ),
      );
    });
  }

  void _onTabTapped(int index) {
    movieTabbedCubit.movieTabChanged(currentTabIndex: index);
  }
}
