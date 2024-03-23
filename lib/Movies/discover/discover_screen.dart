import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manger.dart';
import 'package:movies_app/Model/MovieDiscover.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'package:movies_app/model/ListsMovies.dart';

import 'discover_item.dart';

class DiscoverMovie extends StatefulWidget {
  static const String routeName = 'Movies';


  @override
  State<DiscoverMovie> createState() => _DiscoverMovieState();
}

class _DiscoverMovieState extends State<DiscoverMovie> {
  List<MovieDiscover> allPages = [];
  // int page = 1;
  @override
  void initState() {
    super.initState();
    // loadAllPages();
  }

  // Future<void> loadAllPages() async {
  //   try {
  //     int page = 1;
  //     while (true) {
  //       var movieDiscover = await ApiManager.getMoviesDiscover();
  //       allPages.add(movieDiscover);
  //       if (movieDiscover.page == movieDiscover.totalPages) {
  //         break;
  //       }
  //       page++;
  //     }
  //     setState(() {});
  //   } catch (e) {
  //     print('Error loading pages: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<MovieDiscover>(
            future: ApiManager.getMoviesDiscover(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: MyTheme.whiteColor,
                      color: MyTheme.yellowColor,
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
                          ApiManager.getMoviesDiscover();
                          setState(() {});
                        },
                        icon:  const Icon(Icons.replay_outlined),
                        color: MyTheme.whiteColor,
                      )
                    ],
                  ),
                );
              }
              if (snapshot.data!.results == 7) {
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${snapshot.data!}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyTheme.whiteColor),
                      ),
                      IconButton(
                          onPressed: () {
                            ApiManager.getMoviesDiscover();
                            setState(() {});
                          },
                          icon: const Icon(Icons.replay_outlined,
                              color: MyTheme.whiteColor))
                    ],
                  ),
                );
              }
              var data = snapshot.data?.results ?? [];
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 5.0,
                ),
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return DiscoverMovieItem(
                    movies: data[index],
                  );
                },
              );
            },
          ),
        ],
    );
  }
}