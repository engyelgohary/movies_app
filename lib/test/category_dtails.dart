import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manger.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'package:movies_app/Movies/discover/discover_item.dart';

import '../Model/MovieDiscover.dart';

class CategoryDetails extends StatefulWidget {
  final int categoryId;

  const CategoryDetails({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late Future<List<Results>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = _fetchMoviesByCategory(widget.categoryId);
  }

  Future<List<Results>> _fetchMoviesByCategory(int categoryId) async {
    return await ApiManager.fetchMoviesByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Results>>(
      future: _moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: MyTheme.whiteColor,
              color: MyTheme.yellowColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                const Text('Something went Wrong'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _moviesFuture = _fetchMoviesByCategory(widget.categoryId);
                    });
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No movies found'),
          );
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return DiscoverMovieItem(movies: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}