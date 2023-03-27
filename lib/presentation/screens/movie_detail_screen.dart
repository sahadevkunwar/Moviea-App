import 'package:auto_route/annotations.dart';
import 'package:bloc_project/data/models/movie_details_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key, required this.movieDetailsModel})
      : super(key: key);
  final MovieDetailsModel movieDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is detail page screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(movieDetailsModel.title),
          Text(movieDetailsModel.overview),
        ],
      ),
    );
  }
}
