import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Theme/mytheme.dart';
import '../../Api/toprated_api.dart';
import '../../model/toprated.dart';
import 'toprated_item.dart';


class TopRatedWidget extends StatefulWidget {
  static const String routeName = '';
  const TopRatedWidget({super.key});

  @override
  State<TopRatedWidget> createState() => _TopRatedWidgetState();
}

class _TopRatedWidgetState extends State<TopRatedWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopRated>(
      future: ApiManager.getTopRated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(
            color: MyTheme.whiteColor,
          ));
        } else if (snapshot.hasError){
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('SomeThing went wrong',
                  style: Theme.of(context).textTheme.titleMedium!
                      .copyWith(color: MyTheme.whiteColor),),

                IconButton(onPressed: (){
                  ApiManager.getTopRated();
                  setState(() {

                  });
                }, icon:const Icon( Icons.replay_outlined),color: MyTheme.whiteColor,)
              ],
            ),
          );
        } if (snapshot.data!.status_code == 7) {
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${snapshot.data!.status_message}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: MyTheme.whiteColor),),
                IconButton(onPressed: (){
                  ApiManager.getTopRated();
                  setState(() {

                  });
                }, icon:const Icon( Icons.replay_outlined,color: MyTheme.whiteColor))
              ],
            ),
          );
        }
        var data =snapshot.data?.results??[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Top Rated Movies',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: MyTheme.whiteColor),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.38,
              child: ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TopRatedItem(results: data[index],);
                },),
            ),
          ],
        );
      },
    );
  }
}