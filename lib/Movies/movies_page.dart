import 'package:flutter/material.dart';
import 'package:movies_app/Movies/Movies%20category/categorydetails.dart';
import 'package:movies_app/Theme/mytheme.dart';

class MoviesPage extends StatefulWidget {
  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * .07, left: 10, bottom: 10),
            child: Text(
            'Browse Category'
              , style: Theme
                .of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: MyTheme.whiteColor, fontSize: 24),)),
        Expanded(
            child:
            Category_details()
        )
      ],
    );
  }

}
