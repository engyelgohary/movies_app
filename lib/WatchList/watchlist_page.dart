import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Theme/mytheme.dart';
import 'package:movies_app/firebase/firbase_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:MyTheme.backgroundColor ,
      appBar: AppBar(
        backgroundColor:MyTheme.backgroundColor ,

        title: Text(
          'Watchlist',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: MyTheme.whiteColor, fontSize: 24),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseUtils.getFilmCollection().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final films = snapshot.data!.docs;

            if (films.isEmpty) {
              return Center(child: Text('No Films in WatchList Now',style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: MyTheme.whiteColor, fontSize: 24),));
            } else {
              return ListView.builder(
                itemCount: films.length,
                itemBuilder: (context, index) {
                  final film = films[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                  "https://image.tmdb.org/t/p/w500${film['poster_path']}",                                height:
                                MediaQuery.of(context).size.height * .20,
                                  width: MediaQuery.of(context).size.width * .30,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: MyTheme.whiteColor,
                                      color: MyTheme.yellowColor,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      FirebaseUtils.deleteFilm(film['id'].toString()).then((value) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Film removed Successfully.'),
                                            )
                                        )
                                      });
                                    },
                                    child:
                                    Image.asset('assets/images/select.png')),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    film['title'] ?? '',
                                     maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                          color: MyTheme.whiteColor),
                                  ),
                                  Text(
                                      film['release_date'] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                          fontSize: 15,
                                          color: MyTheme.whiteColor,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: MyTheme.grayColor,
                          thickness: 2,
                          height: 10,
                          endIndent: 10,
                          indent: 10,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}