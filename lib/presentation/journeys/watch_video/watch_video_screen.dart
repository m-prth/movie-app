import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_arguements.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/common/extensions/size_extension.dart';

class WatchVideoScreen extends StatefulWidget {
  final WatchVideoArguements watchVideoArguements;
  const WatchVideoScreen({Key key, @required this.watchVideoArguements})
      : super(key: key);

  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  List<VideoEntity> _videos;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _videos = widget.watchVideoArguements.videos;
    _controller = YoutubePlayerController(
        initialVideoId: _videos[0].key,
        flags: YoutubePlayerFlags(autoPlay: true, mute: true));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.watchTrailer.t(context)),
      ),
      body: YoutubePlayerBuilder(
        builder: (context, player) {
          return Column(
            children: [
              player,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 1; i < _videos.length; i++)
                        Container(
                          height: 60.h,
                          padding: EdgeInsets.symmetric(
                            vertical: Sizes.dimen_8.h,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _controller.load(_videos[i].key);
                                  _controller.play();
                                },
                                child: CachedNetworkImage(
                                  width: Sizes.dimen_200.w,
                                  imageUrl: YoutubePlayer.getThumbnail(
                                    videoId: _videos[i].key,
                                    quality: ThumbnailQuality.high,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Text(
                                    _videos[i].title,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        player: YoutubePlayer(
          controller: _controller,
        ),
      ),
    );
  }
}
