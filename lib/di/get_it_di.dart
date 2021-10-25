import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/authentication_local_data_source.dart';
import 'package:movie_app/data/data_sources/authentication_remote_data_source.dart';
import 'package:movie_app/data/data_sources/local_language_data_source.dart';
import 'package:movie_app/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/app_repository_impl.dart';
import 'package:movie_app/data/repositories/authentication_repository_impl.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'package:movie_app/domain/repositories/authentication_repository.dart';
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
import 'package:movie_app/domain/usecases/get_preffered_theme.dart';
import 'package:movie_app/domain/usecases/get_search_movies.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/domain/usecases/get_videos.dart';
import 'package:movie_app/domain/usecases/login_user.dart';
import 'package:movie_app/domain/usecases/logout_user.dart';
import 'package:movie_app/domain/usecases/save_movies.dart';
import 'package:movie_app/domain/usecases/update_language.dart';
import 'package:movie_app/domain/usecases/update_theme.dart';
import 'package:movie_app/presentation/bloc/cast/cast_cubit.dart';
import 'package:movie_app/presentation/bloc/favorite/favorite_cubit.dart';
import 'package:movie_app/presentation/bloc/language/language_cubit.dart';
import 'package:movie_app/presentation/bloc/loading/loading_cubit.dart';
import 'package:movie_app/presentation/bloc/login/login_cubit.dart';
import 'package:movie_app/presentation/bloc/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:movie_app/presentation/bloc/movie_carousel/movie_carousel_cubit.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:movie_app/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/bloc/theme/theme_cubit.dart';
import 'package:movie_app/presentation/bloc/videos/videos_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());

  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));

  getItInstance
      .registerLazySingleton<GetCastCrew>(() => GetCastCrew(getItInstance()));

  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

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

  getItInstance
      .registerLazySingleton<UpdateTheme>(() => UpdateTheme(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredTheme>(
      () => GetPreferredTheme(getItInstance()));

  getItInstance
      .registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));

  getItInstance
      .registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));

  getItInstance
      .registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
            getItInstance(),
            getItInstance(),
          ));

  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
        getItInstance(),
      ));

  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropCubit());

  getItInstance.registerFactory(
    () => MovieCarouselCubit(
      loadingCubit: getItInstance(),
      getTrending: getItInstance(),
      movieBackdropCubit: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieTabbedCubit(
      getPopular: getItInstance(),
      getComingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieDetailCubit(
      loadingCubit: getItInstance(),
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      videosCubit: getItInstance(),
      favoriteCubit: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => CastCubit(
      getCastCrew: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => VideosCubit(
      getVideos: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => SearchMovieCubit(
      loadingCubit: getItInstance(),
      searchMovies: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageCubit>(LanguageCubit(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));

  getItInstance.registerFactory(() => FavoriteCubit(
        saveMovie: getItInstance(),
        checkIfMovieFavorite: getItInstance(),
        deleteFavoriteMovie: getItInstance(),
        getFavoriteMovies: getItInstance(),
      ));

  getItInstance.registerFactory(() => LoginCubit(
        loginUser: getItInstance(),
        logoutUser: getItInstance(),
        loadingCubit: getItInstance(),
      ));

  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
  getItInstance.registerSingleton<ThemeCubit>(ThemeCubit(
    getPrefferedTheme: getItInstance(),
    updateTheme: getItInstance(),
  ));
}
