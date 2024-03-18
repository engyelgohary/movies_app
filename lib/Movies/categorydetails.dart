import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_listsmovies.dart';
import 'package:movies_app/Movies/categoryitem.dart';

import '../Theme/mytheme.dart';
import '../model/ListsMovies.dart';

class Category_details extends StatefulWidget {
  @override
  State<Category_details> createState() => _Category_detialsState();
}

class _Category_detialsState extends State<Category_details> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListsMovies?>(
      future: ApiMoviesLists.getUpFilms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: MyTheme.whiteColor,
              color: MyTheme.yellowColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                const Text('Smothing went Wrong'),
                ElevatedButton(
                    onPressed: () {
                      ApiMoviesLists.getUpFilms();
                      setState(() {});
                    },
                    child: const Text('Try Again'))
              ],
            ),
          );
        }
        if (snapshot.data?.success == false) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(snapshot.data?.status_message ?? 'Smothing went Wrong'),
              ElevatedButton(
                  onPressed: () {
                    ApiMoviesLists.getUpFilms();
                    setState(() {});
                  },
                  child: const Text('Try Again'))
            ],
          );
        }
        var genres = Genres.getlistsofMovies();

        return GridView.builder(
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing:15 ,mainAxisSpacing:15 ,),
            itemBuilder:(context, index) {
              return CategoryItem(movies: genres[index]);
            },
        itemCount: genres.length,
        );
      },
    );
  }
}
