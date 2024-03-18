import 'package:flutter/material.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'package:movies_app/model/ListsMovies.dart';

class CategoryItem extends StatelessWidget {
Genres movies;
int index;
CategoryItem({required this.movies,required this.index});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/Poster.jpg"),
        Center(child: Text(movies.name??"",style: Theme.of(context).textTheme.titleLarge!.copyWith(color:MyTheme.whiteColor,fontWeight: FontWeight.bold,fontSize: 25),)),
      ],
    );
  }
}
