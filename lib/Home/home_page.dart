import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Home/Recommendedsection/upcoming_details.dart';

import '../Theme/mytheme.dart';


class HomePage extends StatefulWidget  {
  
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return
       Column(
crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Expanded(child: UpComing_details()),
        ],
      );
  }
}
