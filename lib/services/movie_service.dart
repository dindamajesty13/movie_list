import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app/api_config.dart';
import '../models/movie.dart';

class MovieService {
  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/popular?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }
  static Future<List<Movie>> fetchUpcoming() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/upcoming?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch upcoming movies');
    }
  }
  static Future<List<Movie>> fetchNowPlaying() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/now_playing?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch now playing movies');
    }
  }
  static Future<List<Movie>> fetchTopRated() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/top_rated?api_key=${ApiConfig.apiKey}&page=1&sort_by=vote_average.desc',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch top rated movies');
    }
  }
}