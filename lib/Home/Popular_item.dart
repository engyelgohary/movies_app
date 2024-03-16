import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manger.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PopularItems extends StatefulWidget {
  final List<Map<String, dynamic>> movies;

  const PopularItems({Key? key, required this.movies}) : super(key: key);

  @override
  _PopularItemsState createState() => _PopularItemsState();
}

class _PopularItemsState extends State<PopularItems> {
  int _page = 1;
  bool _isLoading = false;
  List<Map<String, dynamic>>? _movies;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
    });
    var movies = await ApiManager.getMovies(page: _page);
    setState(() {
      if (_movies == null) {
        _movies = movies;
      } else {
        _movies!.addAll(movies!);
      }
      _isLoading = false;
    });
  }

  void _loadMoreMovies() {
    if (!_isLoading) {
      setState(() {
        _page++;
      });
      _fetchMovies();
    }
  }

  Widget _buildPoster(String? posterPath, BuildContext context) {
    if (posterPath != null && posterPath.isNotEmpty) {
      return Stack(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500$posterPath',
            fit: BoxFit.cover,
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned.fill(
            bottom: 190,
            child: IconButton(
              icon: const Icon(
                Icons.play_circle,
                size: 70,
                color: Colors.white,
              ),
              onPressed: () {
              },
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels ==
            scrollInfo.metrics.maxScrollExtent) {
          _loadMoreMovies();
        }
        return true;
      },
      child: CarouselSlider.builder(
        itemCount: widget.movies.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          String posterPath = widget.movies[index]['poster_path'];
          return Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                // Larger Movie Poster
                Positioned.fill(
                  child: _buildPoster(posterPath, context),
                ),
                Positioned(
                  top: 210,
                  left: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movies[index]['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.movies[index]['release_date'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Smaller Movie Poster
                Positioned(
                  top: 130,
                  left: 13,
                  child: SizedBox(
                    height: 130,
                    width: 100,
                    child:
                    Image.network(
                      'https://image.tmdb.org/t/p/w500$posterPath',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: 400,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
          viewportFraction: 0.99,
        ),
      ),
    );
  }
}