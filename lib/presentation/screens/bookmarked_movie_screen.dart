import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/core/utils/hive_storage.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BookmarkedMovieScreen extends StatefulWidget {
  const BookmarkedMovieScreen({super.key});

  @override
  State<BookmarkedMovieScreen> createState() => _BookmarkedMovieScreenState();
}

class _BookmarkedMovieScreenState extends State<BookmarkedMovieScreen> {
  List<MovieCardModel> storedMoviesList = [];
  Set<MovieCardModel> storedMoviesSet = {};

  @override
  void initState() {
    super.initState();
    _fetchStoredMovies();
  }

  void _fetchStoredMovies() {
    final data = HiveUtils.fetchMovies();

    final tempList = List<MovieCardModel>.from(data);
    storedMoviesSet = tempList.toSet();
    storedMoviesList = storedMoviesSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          title: const Text('Bookmarked Movie'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    HiveUtils.deleteAllMovies();
                    _fetchStoredMovies();
                    // HiveUtils.fetchMovies();
                  });
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: storedMoviesList.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  // mainAxisExtent: 390,
                  childAspectRatio: 0.6,
                ),
                itemCount: storedMoviesList.length,
                itemBuilder: (context, index) {
                  final movie = storedMoviesList[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          HiveUtils.deleteMovie(movie.id);
                          _fetchStoredMovies();
                          //HiveUtils.fetchMovies();
                        });
                      },
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
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        movie.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        '(${movie.releaseDate.year})',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        movie.overview,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text('No saved movies yet')));
  }
}
