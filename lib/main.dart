import 'package:flutter/material.dart';
import 'package:movie_list/services/service_locator.dart';
import 'package:movie_list/view/home.dart';

void main() async {
  ServiceLocator.init();
  runApp(MovieExplorerApp());
}

class MovieExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalogue',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}