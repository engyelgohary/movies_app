import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Model/MovieDiscover.dart';
import 'package:movies_app/Theme/mytheme.dart';


class DiscoverMovieItem extends StatelessWidget {
  static  String routeName = 'movies';
  Results movies;

  DiscoverMovieItem({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${movies.backdropPath ?? ""}'             ,
              width: double.infinity,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height*.17,
              placeholder: (context, url) =>
               const Center(child: CircularProgressIndicator(
                 backgroundColor: MyTheme.whiteColor,
                 color: MyTheme.yellowColor,
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error,color: MyTheme.yellowColor,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Center(
            child: Text(
              movies.originalTitle??"",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: MyTheme.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
