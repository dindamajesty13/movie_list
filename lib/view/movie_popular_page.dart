import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/movie_service.dart';
import 'movie_list_view.dart';

class MoviePopularPage extends StatefulWidget {
  @override
  _MoviePopularPageState createState() => _MoviePopularPageState();
}

class _MoviePopularPageState extends State<MoviePopularPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final List<Movie> fetchedMovies = await MovieService.fetchMovies();
      setState(() {
        movies = fetchedMovies;
      });
    } catch (e) {
      print('Error fetching popular movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movie'),
      ),
      body: MovieListView(movies: movies),
    );
  }
}