import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Theme/mytheme.dart';

class CustomBookMark
 extends StatelessWidget {
  String  imagePath;
  double ? imageWidth;
  double ? imageHeight;
  double? height;
  double? width;
  double? top;
  double? left;
  double? right;
  double? bottom;

   CustomBookMark
  ({required this.imagePath,this.height,this.left,this.top,this.width,this.bottom});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              width: imageWidth,
                height: imageHeight,
                     

              imageUrl:
                  imagePath??"",
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
         ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                },
                  child: Positioned(
                    height: height,
                    width: width,
                    top: top,
                    bottom:bottom ,
                  right: right,
                  left: left,
                    child: Image.asset('assets/images/bookmark.png'))),
            ),
      ],
      );
  }
}