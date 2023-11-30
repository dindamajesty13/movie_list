import 'package:dio/dio.dart';
import 'package:movie_list/app/api_config.dart';

import '../models/error_message_model.dart';
import '../app/exceptions.dart';
import '../models/movie_details_model.dart';

abstract class MoviesRemoteDataSource {
  Future<MovieDetailsModel> getMovieDetails(int movieId);
}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await Dio().get(ApiConfig.getMovieDetailsPath(movieId));
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
