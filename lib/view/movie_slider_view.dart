import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/app/app_colors.dart';
import 'package:movie_list/app/app_values.dart';
import 'package:movie_list/view/movie_detail_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../app/api_config.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieSliderView extends StatefulWidget {
  MovieSliderView({Key? key}) : super(key: key);

  @override
  State<MovieSliderView> createState() => _SliderPState();
}

class _SliderPState extends State<MovieSliderView> {
  int activeIndex = 0;
  final controller = CarouselController();

  List<Movie> movies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTopRated();
  }

  Future<void> fetchTopRated() async {
    try {
      final List<Movie> fetchTopRated = await MovieService.fetchTopRated();
      setState(() {
        movies = fetchTopRated;
      });
    }catch (e) {
      print('Error fetching top rated movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movie'),
      ),
      backgroundColor: Color.fromARGB(255, 40, 40, 35),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
                carouselController: controller,
                itemCount: movies.length,
                itemBuilder: (context, index, realIndex) {
                  final movie = movies[index];
                  return Container(
                    margin: EdgeInsets.all(AppPadding.p8),
                    child: Column(
                      children: <Widget> [
                        InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailsView(movieId: movie.id,)),
                          );
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s8
                            ),
                            child: buildImage('${ApiConfig.imageBaseUrl}${movie.posterPath}', index)
                        ),
                        ),
                        Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: AppSize.s20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rate_rounded,
                              color: AppColors.ratingIconColor,
                              size: AppSize.s18,
                            ),
                            Text(
                              '${movie.voteAverage}/10',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                    height: 480,
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index))),
            buildIndicator()
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    onDotClicked: animateToSlide,
    effect: ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.blue),
    activeIndex: activeIndex,
    count: movies.length,
  );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) =>
    Container(child: Image.network(urlImage, height: 300.0, fit: BoxFit.cover));