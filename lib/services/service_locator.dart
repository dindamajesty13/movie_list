import 'package:get_it/get_it.dart';

import '../datasource/movies_remote_data_source.dart';
import '../repository/movies_repository.dart';
import '../repository/movies_repository_impl.dart';
import '../usecase/get_movie_details_usecase.dart';
import '../view/movie_details_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {

    sl.registerLazySingleton<MoviesRemoteDataSource>(
            () => MoviesRemoteDataSourceImpl());

    // Repository
    sl.registerLazySingleton<MoviesRespository>(
        () => MoviesRepositoryImpl(sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetMoviesDetailsUseCase(sl()));

    // Bloc
    sl.registerFactory(() => MovieDetailsBloc(sl()));
  }
}
