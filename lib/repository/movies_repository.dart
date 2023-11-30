

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_list/models/movie.dart';

import '../entities/media.dart';
import '../entities/media_details.dart';

abstract class MoviesRespository {
  Future<Either<Failure, MediaDetails>> getMovieDetails(int movieId);
}

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

