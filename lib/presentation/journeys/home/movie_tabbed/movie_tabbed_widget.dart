import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/bloc/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_list_view_builder.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_tabbed_constants.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/tab_title_widget.dart';
import 'package:movie_app/presentation/widgets/app_error_widget.dart';

class MovieTabbedWidget extends StatefulWidget {
  @override
  _MovieTabbedWidgetState createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget>
    with SingleTickerProviderStateMixin {
  MovieTabbedBloc get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedBloc>(context);

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabbedBloc.add(MovieTabChangedEvent(currentTabIndex: currentTabIndex));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
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
              state.movies?.isEmpty ?? true
                  ? Expanded(
                      child: Center(
                          child: Text(
                        TranslationConstants.noMovies.t(context),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                    )
                  : Expanded(
                      child: MovieListViewBuilder(movies: state.movies),
                    ),
            if (state is MovieTabbedLoadError)
              Expanded(
                child: AppErrorWidget(
                  appErrorType: state.appErrorType,
                  onPressed: () => movieTabbedBloc.add(
                    MovieTabChangedEvent(
                      currentTabIndex: state.currentTabIndex,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  void _onTabTapped(int index) {
    movieTabbedBloc.add(MovieTabChangedEvent(currentTabIndex: index));
  }
}
