import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'media_details.dart';

part 'media.g.dart';

@HiveType(typeId: 1)
class Media extends Equatable {
  @HiveField(0)
  final int tmdbID;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String posterUrl;
  @HiveField(3)
  final String backdropUrl;
  @HiveField(4)
  final double voteAverage;
  @HiveField(5)
  final String releaseDate;
  @HiveField(6)
  final String overview;

  const Media({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  factory Media.fromMediaDetails(MediaDetails mediaDetails) {
    return Media(
      tmdbID: mediaDetails.tmdbID,
      title: mediaDetails.title,
      posterUrl: mediaDetails.posterUrl,
      backdropUrl: mediaDetails.backdropUrl,
      voteAverage: mediaDetails.voteAverage,
      releaseDate: mediaDetails.releaseDate,
      overview: mediaDetails.overview,
    );
  }

  @override
  List<Object?> get props => [
        tmdbID,
        title,
        posterUrl,
        backdropUrl,
        voteAverage,
        releaseDate,
        overview,
      ];
}
