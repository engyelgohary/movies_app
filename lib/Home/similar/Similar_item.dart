// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:movies_app/Model/smiler_model.dart';
import 'package:movies_app/widgets/custom_film_widget.dart';

class SimilarItem extends StatelessWidget {
  SimilarResults similarRes;
  SimilarItem({
    Key? key,
    required this.similarRes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CustomFilmWidget(
          imagePath: "https://image.tmdb.org/t/p/w500${similarRes.posterPath}",
           voteAverage: (similarRes.voteAverage ?? 0).toStringAsFixed(1),
            title: similarRes.title??'',
             releaseDate: similarRes.releaseDate??''
  
    );
  }
}
