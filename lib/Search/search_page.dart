import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/search_api.dart';
import 'package:movies_app/Home/movie_details/details_screen.dart';


import 'package:movies_app/Theme/mytheme.dart';

import '../model/search_model.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = TextEditingController();
  SearchApi searchApi = SearchApi();
  SearchModel? searchModel;
  void search(String query) {
    SearchApi.getSearchMovies(query).then((results) {
      setState(() {
        searchModel = results;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyTheme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .025,
                    left: MediaQuery.of(context).size.width * .035,
                    right: MediaQuery.of(context).size.width * .035),
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(12),
                  suffixIcon:
                      const Icon(Icons.cancel, color: MyTheme.whiteColor),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyTheme.whiteColor,
                  ),
                  decoration: BoxDecoration(
                      color: MyTheme.searchColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: MyTheme.whiteColor, width: 1)),
                  controller: searchController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                    } else {
                      search(searchController.text);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              searchModel == null
                  ? const SizedBox.shrink()
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: MyTheme.grayColor,
                          thickness: 3,
                          height: 10,
                          endIndent: 10,
                          indent: 10,
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchModel!.results!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => DetailsScreen(
                                  movieId: searchModel!.results![index].id!,
                                  movieName: searchModel!
                                      .results![index].originalTitle!,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/w500${searchModel!.results?[index].posterPath}",
                                  height: MediaQuery.of(context).size.height *
                                      .20,
                                  width:
                                      MediaQuery.of(context).size.width * .30,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: MyTheme.whiteColor,
                                      color: MyTheme.yellowColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    size: 50,
                                    color: MyTheme.grayColor,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .05,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchModel!.results![index].title ??
                                            '',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: MyTheme.whiteColor),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .05,
                                      ),
                                      Text(
                                          searchModel!
                                              .results![index].releaseDate!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontSize: 10,
                                                  color: MyTheme.whiteColor,
                                                  fontWeight: FontWeight.w300))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
//                                        
