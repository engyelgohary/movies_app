// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/Theme/mytheme.dart';

class CustomFilmWidget extends StatefulWidget {
String imagePath;
String? voteAverage;
String ?title;
String? releaseDate;
Function bookMarkClicked;
//bool isBookmarked;
  CustomFilmWidget({
    //required this.isBookmarked,
   
    required this.imagePath,
    this.voteAverage,
     this.title,
    this.releaseDate,
    required this.bookMarkClicked,
  }) ;

  @override
  State<CustomFilmWidget> createState() => _CustomFilmWidgetState();
}
  bool isBookmarked= false;

class _CustomFilmWidgetState extends State<CustomFilmWidget> {


  @override
  Widget build(BuildContext context) {
     return Container(
      width: MediaQuery.of(context).size.width*.35,
      height:  MediaQuery.of(context).size.height*.01,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top:  MediaQuery.of(context).size.height*.01, 
      bottom:  MediaQuery.of(context).size.height*.01),
      color: MyTheme.darkGrayColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyTheme.mediumGrayColor,
        ),
       
        margin: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl:
                            widget.imagePath,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: MyTheme.whiteColor,
                            color: MyTheme.yellowColor,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Center(child: const Icon(Icons.error,size: 50,color: MyTheme.grayColor,)),
                      )),
                InkWell(
              onTap: () {
                widget.bookMarkClicked;
              },
              child: isBookmarked
                  ? Image.asset('assets/images/select.png')
                  : Image.asset('assets/images/bookmark.png'),),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: MyTheme.yellowColor,
                      size: 17,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.voteAverage??'',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.whiteColor),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  widget.title??'',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyTheme.whiteColor,fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  widget.releaseDate??'',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 10, color: MyTheme.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  
  }

  // 
}
