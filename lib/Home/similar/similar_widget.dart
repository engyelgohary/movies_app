// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/Api/similar_api.dart';
import 'package:movies_app/Home/similar/Similar_item.dart';
import 'package:movies_app/Model/smiler_model.dart';
import 'package:movies_app/Theme/mytheme.dart';

class SimilarWidget extends StatefulWidget {
  static const String routeName = '';
int movieId;
   SimilarWidget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<SimilarWidget> createState() => _SimilarWidgetState();
}

class _SimilarWidgetState extends State<SimilarWidget> {
  SimilarApi movieDetailsApi = SimilarApi();
  late Future<SimilarModel> movieDetails;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  fetchMovieDetails() {
    movieDetails = SimilarApi.getSimilarMovies(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SimilarModel>(
      future: SimilarApi.getSimilarMovies(widget.movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: MyTheme.whiteColor,
          ));
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    SimilarApi.getSimilarMovies(widget.movieId);
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
                      SimilarApi.getSimilarMovies(widget.movieId);
                      setState(() {});
                    },
                    icon: const Icon(Icons.replay_outlined,
                        color: MyTheme.whiteColor))
              ],
            ),
          );
        }
        var similarList = snapshot.data!.results ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'More Like This',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.whiteColor),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .38,
              child: ListView.builder(
                itemCount: similarList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SimilarItem(similarRes: similarList[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
