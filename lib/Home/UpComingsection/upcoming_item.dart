import 'package:flutter/material.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Model/upcomingfilm.dart';

class UpcomingItem extends StatelessWidget {
  Results res;
  UpcomingItem({required this.res});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.darkGrayColor,
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
         ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: CachedNetworkImage(
            imageUrl:
                'https://image.tmdb.org/t/p/w500${res.posterPath ?? ""}',
            height: 250,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                backgroundColor: MyTheme.whiteColor,
                color: MyTheme.yellowColor,
              ),
            ),
            errorWidget: (context, url, error) => Center(
                child: Icon(
              Icons.error,
              color: MyTheme.yellowColor,
            )),
          ),
        ),
            InkWell(
              onTap: (){},
                child: Image.asset('assets/images/bookmark.png')),
      ],
      ),
    );
  }
}
