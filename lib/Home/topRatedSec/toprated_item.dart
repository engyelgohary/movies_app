// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movies_app/Api/toprated_api.dart';
import 'package:movies_app/widgets/custom_film_widget.dart';
import '../../model/toprated.dart';

class TopRatedItem extends StatelessWidget {
  Results results;
  TopRatedItem({
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFilmWidget(
    imagePath: "${ApiConstantT.imageUrl}${results.posterPath}",
      voteAverage: (results.voteAverage ?? 0).toStringAsFixed(1),
      title: results.title ?? "",
      releaseDate: results.releaseDate ?? "",
    );
    }
}
