// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/Model/movie_details_model.dart';
import 'package:movies_app/Theme/mytheme.dart';

import '../similar/similar_widget.dart';

class DetailsItem extends StatefulWidget {
  MovieDetailsModel movie;
    int movieId;

  DetailsItem({
    Key? key,
    required this.movie,
    required this.movieId,
  }) : super(key: key);

  @override
  State<DetailsItem> createState() => _DetailsItemState();
}

class _DetailsItemState extends State<DetailsItem> {
  @override
  Widget build(BuildContext context) {
    return    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${widget.movie?.backdropPath}',
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
                          widget.movie?.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.whiteColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 15),
                        child: Text(
                          widget.movie?.releaseDate ?? '',
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
                                  'https://image.tmdb.org/t/p/w500${widget.movie?.posterPath}',
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
                                    "${widget.movie?.overview ?? ''}'",
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
                                        (widget.movie!.voteAverage ?? 0).toStringAsFixed(1),
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
               ;
  }
}
