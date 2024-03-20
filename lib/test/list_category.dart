import 'package:flutter/material.dart';
import 'package:movies_app/Movies/Movies%20category/categoryitem.dart';

import '../model/ListsMovies.dart';
import 'category_dtails.dart';

class CategoryList extends StatelessWidget {
  final List<Genres> genres;

  const CategoryList({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CategoryDetails(categoryId: genres[index].id ?? 0),
              ),
            );
          },
          child: CategoryItem(movies: genres[index], index: index),
        );
      },
    );
  }
}