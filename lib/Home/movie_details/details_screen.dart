// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/movie_details_api.dart';
import 'package:movies_app/Api/toprated_api.dart';

import 'package:movies_app/Home/similar/Similar_item.dart';
import 'package:movies_app/Home/similar/similar_widget.dart';
import 'package:movies_app/Model/movie_details_model.dart';
import 'package:movies_app/Model/smiler_model.dart';
import 'package:movies_app/Theme/mytheme.dart';

class DetailsScreen extends StatefulWidget {
  int movieId;
  String movieName;
  MovieDetailsModel? model;
  DetailsScreen({
    Key? key,
    this.model,
    required this.movieId,
    required this.movieName,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MovieDetailsApi movieDetailsApi = MovieDetailsApi();
  late Future<MovieDetailsModel> movieDetails;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails(widget.movieName);
  }

  fetchMovieDetails(String movieName) {
    movieDetails = MovieDetailsApi.getMovieDetails(widget.movieId,widget.movieName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyTheme.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.movieName
          ,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: MyTheme.whiteColor,fontWeight:FontWeight.bold,fontSize: 20),),
          backgroundColor: MyTheme.bottomColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<MovieDetailsModel>(
              future: movieDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: MyTheme.whiteColor,
                  ));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SomeThing went wrong',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.whiteColor),
                        ),
                        IconButton(
                          onPressed: () {
                            MovieDetailsApi.getMovieDetails(widget.movieId);
                            setState(() {});
                          },
                          icon: const Icon(Icons.replay_outlined),
                          color: MyTheme.whiteColor,
                        )
                      ],
                    ),
                  );
                }
                if (snapshot.data!.status_code == 7) {
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${snapshot.data!.status_message}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.whiteColor),
                        ),
                        IconButton(
                            onPressed: () {
                              MovieDetailsApi.getMovieDetails(widget.movieId);
                              setState(() {});
                            },
                            icon: const Icon(Icons.replay_outlined,
                                color: MyTheme.whiteColor))
                      ],
                    ),
                  );
                }
                if (snapshot.hasData) {
                  var movie = snapshot.data;
                  return 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie?.backdropPath}',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * .35,
                        //width: MediaQuery.of(context).size.width * .99,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: MyTheme.whiteColor,
                            color: MyTheme.yellowColor,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          movie?.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.whiteColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 15),
                        child: Text(
                          movie?.releaseDate ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: MyTheme.whiteColor,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly

                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height * .3,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: MyTheme.whiteColor,
                                  color: MyTheme.yellowColor,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error,color: MyTheme.yellowColor,),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${movie?.overview ?? ''}'",
                                    maxLines: 6,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: MyTheme.whiteColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: MyTheme.yellowColor,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        (movie!.voteAverage ?? 0).toStringAsFixed(1),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color: MyTheme.whiteColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SimilarWidget(movieId: widget.movieId)
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ));
  }
}
