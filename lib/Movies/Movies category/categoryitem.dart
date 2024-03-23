import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manger.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'package:movies_app/Movies/discover/discover_item.dart';
import '../../Home/movie_details/details_screen.dart';
import '../../Model/MovieDiscover.dart';


class CategoryItem extends StatefulWidget {
  static String routeName = "categpry";
  final int categoryId;
  final String categoryName;

  const CategoryItem({Key? key, required this.categoryId,required this.categoryName}) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late Future<List<Results>> _moviesFuture;
  @override
  void initState() {
    super.initState();
    _moviesFuture = _fetchMoviesByCategory(widget.categoryId,widget.categoryName);
  }

  Future<List<Results>> _fetchMoviesByCategory(int categoryId,String categoryName) async {
    return await ApiManager.fetchMoviesByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: MyTheme.bottomColor,
          title: Text(widget.categoryName,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Results>>(
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
                          _moviesFuture = _fetchMoviesByCategory(widget.categoryId,widget.categoryName);
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
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing:10,
                    mainAxisSpacing:10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => DetailsScreen(
                                movieId:snapshot.data![index].id!,movieName:snapshot.data![index].originalTitle!,

                              ),));
                        },
                        child: DiscoverMovieItem(movies: snapshot.data![index]));
                  },
                ),
              );
            }
          },
        ));
  }
}