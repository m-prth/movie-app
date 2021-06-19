import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/presentation/bloc/videos/videos_bloc.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_arguements.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_screen.dart';
import 'package:movie_app/presentation/widgets/button.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';

class VideosWidget extends StatelessWidget {
  final VideosBloc videosBloc;

  const VideosWidget({Key key, this.videosBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: videosBloc,
      builder: (context, state) {
        if (state is VideosLoaded && state.videos.iterator.moveNext()) {
          final _videos = state.videos;
          return Button(
            text: TranslationConstants.watchTrailer,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WatchVideoScreen(
                    watchVideoArguements: WatchVideoArguements(_videos),
                  ),
                ),
              );
            },
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
