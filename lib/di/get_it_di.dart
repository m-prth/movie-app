import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/local_language_data_source.dart';
import 'package:movie_app/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/app_repository_impl.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/check_if_movie_favorite.dart';
import 'package:movie_app/domain/usecases/delete_favorite_movies.dart';
import 'package:movie_app/domain/usecases/get_cast_crew.dart';
import 'package:movie_app/domain/usecases/get_coming_soon.dart';
import 'package:movie_app/domain/usecases/get_favorite_movies.dart';
import 'package:movie_app/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/domain/usecases/get_playing_now.dart';
import 'package:movie_app/domain/usecases/get_popular.dart';
import 'package:movie_app/domain/usecases/get_preferred_language.dart';
import 'package:movie_app/domain/usecases/get_search_movies.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/domain/usecases/get_videos.dart';
import 'package:movie_app/domain/usecases/save_movies.dart';
import 'package:movie_app/domain/usecases/update_language.dart';
import 'package:movie_app/presentation/bloc/cast/cast_bloc.dart';
import 'package:movie_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:movie_app/presentation/bloc/language/language_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/bloc/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  // ! clients
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // ! datasources
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());

  // ! usecases
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance
      .registerLazySingleton<GetCastCrew>(() => GetCastCrew(getItInstance()));
  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));
  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));
  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovies>(
      () => DeleteFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfMovieFavorite>(
      () => CheckIfMovieFavorite(getItInstance()));
  getItInstance.registerLazySingleton<UpdateLanguage>(
      () => UpdateLanguage(getItInstance()));
  getItInstance.registerLazySingleton<GetPreferredLanguage>(
      () => GetPreferredLanguage(getItInstance()));

  // ! repository
  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(getItInstance()));

  // ! blocs
  getItInstance.registerFactory(() => MovieCarouselBloc(
      getTrending: getItInstance(), movieBackdropBloc: getItInstance()));
  getItInstance.registerFactory(() => MovieBackdropBloc());
  getItInstance.registerFactory(() => MovieTabbedBloc(
        getComingSoon: getItInstance(),
        getPlayingNow: getItInstance(),
        getPopular: getItInstance(),
      ));
  getItInstance.registerFactory(() => MovieDetailBloc(
        favoriteBloc: getItInstance(),
        getMovieDetail: getItInstance(),
        castBloc: getItInstance(),
        videosBloc: getItInstance(),
      ));
  getItInstance.registerFactory(() => CastBloc(getCastCrew: getItInstance()));
  getItInstance.registerFactory(() => VideosBloc(getVideos: getItInstance()));
  getItInstance
      .registerFactory(() => SearchMovieBloc(searchMovies: getItInstance()));
  getItInstance.registerFactory(
    () => FavoriteBloc(
      saveMovie: getItInstance(),
      getFavoriteMovies: getItInstance(),
      deleteFavoriteMovies: getItInstance(),
      checkIfMovieFavorite: getItInstance(),
    ),
  );

  // ! internalionalization
  getItInstance.registerSingleton<LanguageBloc>(
    LanguageBloc(
      getPreferredLanguage: getItInstance(),
      updateLanguage: getItInstance(),
    ),
  );
}
