import 'package:flutter/material.dart';
import 'package:movie_list/view/movie_grid_view.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieUpcomingPage extends StatefulWidget {
  @override
  _MovieUpcomingPageState createState() => _MovieUpcomingPageState();
}

class _MovieUpcomingPageState extends State<MovieUpcomingPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchUpcoming();
  }

  Future<void> fetchUpcoming() async {
    try {
      final List<Movie> fetchedUpcoming = await MovieService.fetchUpcoming();
      setState(() {
        movies = fetchedUpcoming;
      });
    } catch (e) {
      print('Error fetching upcoming movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Movie'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MovieGridView(movies: movies,)
          ),
        ]
      ),
    );
  }
}