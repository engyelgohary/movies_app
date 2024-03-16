// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Theme/mytheme.dart';
import '../../model/toprated.dart';

class TopRatedItem extends StatelessWidget {
  Results results;
  TopRatedItem({
    required this.results,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      color: MyTheme.darkGrayColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyTheme.mediumGrayColor,
        ),
        width: 120,
        height: 150,
        margin: EdgeInsets.all(7),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl:
                    "https://image.tmdb.org/t/p/w500${results.posterPath}",
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.whiteColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: MyTheme.yellowColor,
                      size: 17,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      (results.voteAverage ?? 0).toStringAsFixed(1),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.whiteColor),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: Text(
                  results.title ?? "",
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyTheme.whiteColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: Text(
                  results.releaseDate ?? "",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 10, color: MyTheme.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// "https://image.tmdb.org/t/p/w500${results.posterPath}"
/*
  child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: results.posterPath??'',
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(
                child: Text(
                  "NO IMAGE",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                alignment: AlignmentDirectional.topStart,
                width: double.infinity,
                height: 128,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
                child: Image.asset("assets/images/add_icon.png"),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        (results.voteAverage ?? 0).toStringAsFixed(1),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    results.title ?? "",
                    maxLines: 2,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    results.releaseDate ?? "",
                    style: TextStyle(
                        fontSize: 8,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
          ],
        ),

*/