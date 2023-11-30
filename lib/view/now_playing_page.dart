import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/app/app_values.dart';

import '../models/movie.dart';
import '../services/movie_service.dart';
import 'movie_grid_view.dart';

class NowPlayingPage extends StatefulWidget {
  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchNowPlaying();
  }

  Future<void> fetchNowPlaying() async {
    try {
      final List<Movie> fetchNowPlaying = await MovieService.fetchNowPlaying();
      setState(() {
        movies = fetchNowPlaying;
      });
    } catch (e) {
      print('Error fetching now playing movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing in Theaters'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: Text(
              'Search for a movie',
              style: TextStyle(
                color: Colors.black,
                fontSize: AppSize.s22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AnimSearchBar(
            width: 400,
            textController: textController,
            onSuffixTap: () {
              setState(() {
                textController.clear();
              });
            },
            rtl: true,
            onSubmitted: (String text) {  },
          ),
          Expanded(child: MovieGridView(movies: movies,),)
        ]
      )
    );
  }
}