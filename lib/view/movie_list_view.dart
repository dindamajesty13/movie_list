import 'package:flutter/material.dart';
import 'package:movie_list/app/app_colors.dart';
import 'package:movie_list/app/app_values.dart';
import '../app/api_config.dart';
import '../models/movie.dart';
import 'image_with_shimmer.dart';
import 'movie_detail_page.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movies;

  const MovieListView({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailsView(movieId: movie.id,)),
            );
          },
          child: ListTile(
            leading: ImageWithShimmer(
              imageUrl: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
              width: AppSize.s84,
              height: AppSize.s84,
            ),
            title: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis
            ),
            subtitle: Text(
              movie.overview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              children: [
                const Icon(
                  Icons.star_rate_rounded,
                  color: AppColors.ratingIconColor,
                  size: AppSize.s18,
                ),
                Text(
                  '${movie.voteAverage}/10',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}