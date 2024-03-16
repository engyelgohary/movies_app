// ignore_for_file: use_key_in_widget_constructors, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:movies_app/Api/upcoming_api.dart';
import 'package:movies_app/Model/upcomingfilm.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'upcoming_item.dart';


class UpComing_details extends StatefulWidget {



  @override
  State<UpComing_details> createState() => _News_detialsState();
}

class _News_detialsState extends State<UpComing_details> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Upcomingfilm?>(
      future: ApiRecommended.getUpFilms(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
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
  
        return ListView.builder(itemBuilder: (context, index) {
          return UpcomingItem(res: filmList[index]);
        },
          itemCount: filmList.length,
          scrollDirection: Axis.horizontal,
        );
      },
    );
  }
}