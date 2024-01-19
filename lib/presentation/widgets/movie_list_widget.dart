// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_project/core/utils/hive_storage.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({
    Key? key,
    required this.onClick,
    required this.movieFetched,
  }) : super(key: key);
  final Function(int id) onClick;
  final MovieFetched movieFetched;

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final Set<MovieCardModel> movieSetCollection = {};

  List<MovieCardModel> _storedList = [];
  @override
  void initState() {
    super.initState();
    _storedList = _fetchStoredMovies();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        // mainAxisExtent: 390,
        childAspectRatio: 0.6,
      ),
      itemCount: widget.movieFetched.moviesCard.length,
      itemBuilder: (context, index) {
        final movie = widget.movieFetched.moviesCard[index];

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => widget.onClick(movie.id),
            child: Stack(
              //alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: 180,
                  height: 290,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      width: 170,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageUrl:
                          'https://image.tmdb.org/t/p/w300${movie.posterPath}',
                    ),
                  ),
                ),
                Align(
                  // alignment: Alignment.bottomCenter,
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Colors.black87,
                    ),
                    child: Container(
                      color: const Color(0xff7052ff).withOpacity(0.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              movie.title,
                              maxLines: 2,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              '(${movie.releaseDate.year})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(3.0),
                          //   child: Text(
                          //     movie.overview,
                          //     overflow: TextOverflow.ellipsis,
                          //     maxLines: 2,
                          //     style: const TextStyle(
                          //         color: Colors.white54, fontSize: 13),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      _storedList = _fetchStoredMovies();
                      movieSetCollection.addAll(_storedList);
                      movieSetCollection.add(movie);

                      HiveUtils.storeMovies(movieSetCollection.toList());
                      setState(() {
                        _storedList = _fetchStoredMovies();
                      });
                    },
                    icon: _checkBookmarkedMovie(movie),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Icon _checkBookmarkedMovie(MovieCardModel movie) {
    if (_storedList.any((element) => element.id == movie.id)) {
      return const Icon(
        Icons.bookmark_outlined,
        color: Colors.purple,
      );
    } else {
      return const Icon(
        Icons.bookmark_border,
        color: Colors.white,
      );
    }
  }

  List<MovieCardModel> _fetchStoredMovies() {
    final data = HiveUtils.fetchMovies();
    final listData = List<MovieCardModel>.from(data);
    return listData;
  }
}
