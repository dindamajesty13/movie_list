import 'package:flutter/material.dart';
import 'package:movie_list/app/app_colors.dart';
import 'package:movie_list/app/app_values.dart';
import 'package:movie_list/view/movie_detail_page.dart';
import '../app/api_config.dart';
import '../models/movie.dart';
import 'image_with_shimmer.dart';

class MovieGridView extends StatelessWidget {
  final List<Movie> movies;

  const MovieGridView({required this.movies});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSize.s8,
        crossAxisSpacing: AppSize.s8,
      ),
      padding: const EdgeInsets.all(AppPadding.p8),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return SizedBox(
          height: AppSize.s240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailsView(movieId: movie.id,)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ImageWithShimmer(
                    imageUrl: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                    width: double.infinity,
                    height: AppSize.s150,
                  ),
                ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        color: AppColors.ratingIconColor,
                        size: AppSize.s18,
                      ),
                      Text(
                        '${movie.voteAverage}/10',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}