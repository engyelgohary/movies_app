// ignore_for_file: use_key_in_widget_constructors, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:movies_app/Api/upcoming_api.dart';
import 'package:movies_app/Home/movie_details/details_screen.dart';
import 'package:movies_app/Model/upcomingfilm.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'upcoming_item.dart';


class UpComing_details extends StatefulWidget {



  @override
  State<UpComing_details> createState() => _UpComing_detialsState();
}

class _UpComing_detialsState extends State<UpComing_details> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Upcomingfilm?>(
      future: ApiRecommended.getUpFilms(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: MyTheme.whiteColor,
              color: MyTheme.yellowColor,
            ),
          );
        } else if(snapshot.hasError){
          return Center(
            child: Column(
              children: [
                const Text('Smothing went Wrong'),
                ElevatedButton(onPressed: (){
                 ApiRecommended.getUpFilms();
                  setState(() {
          
                  });
                }, child: const Text('Try Again'))
              ],
            ),
          );
        }
        if(snapshot.data?.success == false){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(snapshot.data?.status_message ??'Smothing went Wrong'),
              ElevatedButton(onPressed: (){
               ApiRecommended.getUpFilms();
                setState(() {

                });
              }, child: const Text('Try Again'))
            ],
          );
        }
        var filmList = snapshot.data?.results ?? [];
  
        return Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Up Coming Movies',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: MyTheme.whiteColor),),
            ),
        SizedBox(
           height: MediaQuery.of(context).size.height*.27,

          child: ListView.builder(itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => DetailsScreen(movieId: filmList[index].id!,movieName: filmList[index].originalTitle!),));
              },
              child: UpcomingItem(res: filmList[index]));
          },
            itemCount: filmList.length,
            scrollDirection: Axis.horizontal,
          ),
        )
          ],
        );
      },
    );
  }
}
