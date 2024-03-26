import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manger.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/Home/movie_details/details_screen.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'package:movies_app/firebase/firbase_utils.dart';
import 'package:movies_app/model/Popular.dart';

class PopularItems extends StatefulWidget {
  final List<Map<String, dynamic>> movies;

  const PopularItems({Key? key, required this.movies}) : super(key: key);

  @override
  _PopularItemsState createState() => _PopularItemsState();
}

class _PopularItemsState extends State<PopularItems> {
  int _page = 1;
  bool _isLoading = false;
  bool isBookmarked = false;
  List<bool> _isBookmarkedList = [];

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
      if (_isBookmarkedList.isEmpty) {
        _isBookmarkedList = List.filled(movies!.length, false);
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
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500$posterPath',
            fit: BoxFit.cover,
            height: MediaQuery
                .of(context)
                .size
                .height * .23,
            width: MediaQuery
                .of(context)
                .size
                .width,
          ),
          Positioned.fill(
            bottom: 100,
            child: IconButton(
              icon: const Icon(
                Icons.play_circle,
                size: 70,
                color: Colors.white,
              ),
              onPressed: () {},
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
    void _toggleBookmark(index) {
      setState(() {
        _isBookmarkedList[index] = !_isBookmarkedList[index];

        if (_isBookmarkedList[index]) {
          Results result = Results(
            title: widget.movies[index]['title'],
            posterPath: widget.movies[index]['poster_path'],
            releaseDate: widget.movies[index]['release_date'],
          );
          FirebaseUtils.addFilmToFirestore(result.toJson()).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Film Added Successfully to Watchlist.'),
              ),
            );
          }).catchError((error) {
            print('Error adding film to Firestore: $error');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to add film.'),
              ),
            );
          });
        } else {
          String filmTitle = widget.movies[index]['title'];
          FirebaseUtils.getFilmId(filmTitle).then((filmId) {
            if (filmId != null) {
              FirebaseUtils.deleteFilm(filmId).then((value) {
                print('Film Deleted Successfully');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Film Removed Successfully.'),
                  ),
                );
              }).catchError((error) {
                print('Error deleting film: $error');
              });
            } else {
              print('Film not found in database.');
            }
          });
        }
      });
    }
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
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
              String coverPath = widget.movies[index]['backdrop_path'];

              return InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute
                    (builder: (context) =>
                      DetailsScreen(movieId: widget.movies[index]['id'],
                        movieName: widget.movies[index]['original_title'],)));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      // Larger Movie Poster
                      Positioned.fill(
                        child: _buildPoster(coverPath, context),
                      ),

                      Positioned(
                        top: 210,
                        left: 150,
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
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, CupertinoPageRoute
                                  (builder: (context) =>
                                    DetailsScreen(
                                      movieId: widget.movies[index]['id'],
                                      movieName: widget
                                          .movies[index]['original_title'],)));
                              },
                              child: Container(
                                height: 150,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500$posterPath',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: InkWell(
                                onTap: () {
                                  if (index >= 0 && index < _isBookmarkedList.length) {
                                    _toggleBookmark(index);
                                  }
                                },
                                child: index >= 0 && index < _isBookmarkedList.length ?
                                _isBookmarkedList[index]
                                    ? GestureDetector(
                                  onTap: () => _toggleBookmark(index),
                                  child: Image.asset('assets/images/select.png'),
                                )
                                    : GestureDetector(
                                  onTap: () => _toggleBookmark(index),
                                  child: Image.asset('assets/images/bookmark.png'),
                                )
                                    : const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .35,
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
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(
              backgroundColor: MyTheme.whiteColor,
              color: MyTheme.yellowColor,
            ),
          ),
      ],
    );
  }
}

