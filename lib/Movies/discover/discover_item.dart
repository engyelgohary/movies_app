import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Model/MovieDiscover.dart';
import 'package:movies_app/Theme/mytheme.dart';


class DiscoverMovieItem extends StatelessWidget {
  static  String routeName = 'movies';
  late Results movies;

  DiscoverMovieItem({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${movies.backdropPath ?? ""}'             ,
              width: double.infinity,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Expanded(
          child: Center(
            child: Text(
              movies.originalTitle??"",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: MyTheme.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
