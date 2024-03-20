import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'category_dtails.dart';

class MovieGenre {
  final int id;
  final String name;

  MovieGenre({required this.id, required this.name});

  factory MovieGenre.fromJson(Map<String, dynamic> json) {
    return MovieGenre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Test extends StatelessWidget {
  Future<List<MovieGenre>> fetchGenres() async {
    final apiKey = 'c1265a8ce88388fdd90cabcf16515a92';
    final response = await http.get(
      Uri.https('api.themoviedb.org', '/3/genre/movie/list', {'api_key': apiKey}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['genres'];
      return data.map((json) => MovieGenre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movie Genres'),
        ),
        body: FutureBuilder<List<MovieGenre>>(
          future: fetchGenres(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final genre = snapshot.data![index];
                  return ListTile(
                    title:
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryDetails(categoryId: genre.id),
                            ),
                          );
                        },
                        child: Text(genre.name)),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
