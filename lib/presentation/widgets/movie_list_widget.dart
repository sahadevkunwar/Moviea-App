// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({
    Key? key,
    required this.onClick,
    required this.movieFetched,
  }) : super(key: key);
  final Function(int id) onClick;
  final MovieFetched movieFetched;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 390,
      ),
      itemCount: movieFetched.moviesCard.length,
      itemBuilder: (context, index) {
        final movie = movieFetched.moviesCard[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => onClick(movie.id),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 58, 56, 56),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w300${movie.posterPath}',
                              height: 190,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          '(${movie.releaseDate.year})',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  movie.overview,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      //   child: Text(
                      //     movie.backdropPath,
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
