import 'package:flutter/material.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/firebase/firebase_utilsUpcomingsec.dart';
import '../../Model/upcomingfilm.dart';

class UpcomingItem extends StatefulWidget {
  Results res;
  UpcomingItem({required this.res});

  @override
  State<UpcomingItem> createState() => _UpcomingItemState();
}

class _UpcomingItemState extends State<UpcomingItem> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.darkGrayColor,
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.res.posterPath ?? ""}',
              height: 250,
              placeholder: (context, url) =>
                  const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: MyTheme.whiteColor,
                      color: MyTheme.yellowColor,
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  const Center(
                      child: Icon(
                        Icons.error,
                        color: MyTheme.yellowColor,
                      )),
            ),
          ),
          InkWell(
              onTap: () {
                _toggleBookmark();
              },
              child:  isBookmarked
                  ? Image.asset('assets/images/select.png')
                  : Image.asset('assets/images/bookmark.png'),),
        ],
      ),
    );
  }

  void _toggleBookmark() {
      isBookmarked = ! isBookmarked;
      if (isBookmarked) {
        setState(() {
          Results result = Results(
              id: widget.res.id,
              title: widget
                  .res.title,
              posterPath: widget
                  .res.posterPath,
              releaseDate: widget
                  .res.releaseDate
          );
          FirebaseUtilsUpComingSec.addFilmToFireStore(
              result: result).then((value) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(
                  content: Text(
                      'Film Added Successfully.'),
                )
            );
          }
          );
        });
      }
    }
  }

