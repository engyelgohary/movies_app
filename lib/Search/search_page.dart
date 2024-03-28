import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/search_api.dart';
import 'package:movies_app/Home/movie_details/details_screen.dart';

import 'package:movies_app/Model/search_model.dart';
import 'package:movies_app/Search/view_seaech_screen.dart';

import 'package:movies_app/Theme/mytheme.dart';

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
                  : 
                ViewSearchScreen(searchModel: searchModel)
                 ],
          ),
        ),
      ),
    );
  }
}
//                                        
