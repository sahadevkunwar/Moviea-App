import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/core/utils/shared_prefs.dart';
import 'package:bloc_project/data/models/movie_details_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.movieDetailsModel})
      : super(key: key);
  final MovieDetailsModel movieDetailsModel;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  String appBarTitle = '';
  @override
  void initState() {
    super.initState();
    appBarTitle = getAppBarTitle();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(appBarTitle),

        // ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w300${widget.movieDetailsModel.posterPath}',
                      //height: 320,
                      // width: double.infinity,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Overview',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => context.popRoute(),
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      iconSize: 30.0,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => context.popRoute(),
                        icon: const Icon(Icons.bookmark),
                        color: Colors.white,
                        iconSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.movieDetailsModel.title,
                          style: const TextStyle(
                              fontSize: 27, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "(${widget.movieDetailsModel.releaseDate.year.toString()})",
                          style: const TextStyle(
                              fontSize: 27, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(255, 110, 110, 110),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Adventure',
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(255, 110, 110, 110),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Fantasy',
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(255, 110, 110, 110),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Comedy',
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign: TextAlign.start,
                    'Storyline',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.movieDetailsModel.overview,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getAppBarTitle() {
  return PreferenceUtils.getString('titleBarKey');
}
