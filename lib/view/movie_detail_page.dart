import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/app/app_values.dart';
import '../components/cast_card.dart';
import '../components/details_card.dart';
import '../components/error_screen.dart';
import '../components/loading_indicator.dart';
import '../components/movie_card_details.dart';
import '../components/overview_section.dart';
import '../components/review_card.dart';
import '../components/section_listview.dart';
import '../components/section_listview_card.dart';
import '../components/section_title.dart';
import '../entities/cast.dart';
import '../entities/media.dart';
import '../entities/media_details.dart';
import '../entities/review.dart';
import '../services/service_locator.dart';
import '../utils/enums.dart';
import 'movie_details_bloc.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;

  const MovieDetailsView({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      sl<MovieDetailsBloc>()..add(GetMovieDetailsEvent(movieId)),
      child: Scaffold(
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return MovieDetailsWidget(movieDetails: state.movieDetails!);
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<MovieDetailsBloc>()
                        .add(GetMovieDetailsEvent(movieId));
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({
    required this.movieDetails,
    super.key,
  });

  final MediaDetails movieDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsCard(
            mediaDetails: movieDetails,
            detailsWidget: MovieCardDetails(movieDetails: movieDetails),
          ),
          getOverviewSection(movieDetails.overview),
          _getCast(movieDetails.cast),
          _getReviews(movieDetails.reviews),
          getSimilarSection(movieDetails.similar),
          const SizedBox(height: AppSize.s8),
        ],
      ),
    );
  }
}

Widget getSimilarSection(List<Media>? similar) {
  if (similar != null && similar.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Similar'),
        SectionListView(
          height: AppSize.s240,
          itemCount: similar.length,
          itemBuilder: (context, index) => SectionListViewCard(
            media: similar[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}

Widget getOverviewSection(String overview) {
  if (overview.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Overview'),
        OverviewSection(overview: overview),
      ],
    );
  } else {
    return const SizedBox();
  }
}

Widget _getCast(List<Cast>? cast) {
  if (cast != null && cast.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Cast'),
        SectionListView(
          height: AppSize.s200,
          itemCount: cast.length,
          itemBuilder: (context, index) => CastCard(
            cast: cast[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}

Widget _getReviews(List<Review>? reviews) {
  if (reviews != null && reviews.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Review'),
        SectionListView(
          height: AppSize.s200,
          itemCount: reviews.length,
          itemBuilder: (context, index) => ReviewCard(
            review: reviews[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}