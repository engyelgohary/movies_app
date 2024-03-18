/// genres : [{"id":28,"name":"Action"},{"id":12,"name":"Adventure"},{"id":16,"name":"Animation"},{"id":35,"name":"Comedy"},{"id":80,"name":"Crime"},{"id":99,"name":"Documentary"},{"id":18,"name":"Drama"},{"id":10751,"name":"Family"},{"id":14,"name":"Fantasy"},{"id":36,"name":"History"},{"id":27,"name":"Horror"},{"id":10402,"name":"Music"},{"id":9648,"name":"Mystery"},{"id":10749,"name":"Romance"},{"id":878,"name":"Science Fiction"},{"id":10770,"name":"TV Movie"},{"id":53,"name":"Thriller"},{"id":10752,"name":"War"},{"id":37,"name":"Western"}]

class ListsMovies {
  ListsMovies({
      this.genres,
    this.status_code,
    this.status_message,this.success});

  ListsMovies.fromJson(dynamic json) {
    success=json['success'];
    status_code=json['status_code'];
    status_message=json['status_message'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(Genres.fromJson(v));
      });
    }
  }
  List<Genres>? genres;
  bool? success;
  int? status_code;
  String? status_message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 28
/// name : "Action"

class Genres {
  Genres({
     required this.id,
      required this.name,});

  Genres.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
static List<Genres> getlistsofMovies(){
    return [
      Genres(id: 28, name: "Action"),
      Genres(id: 12 ,name: "Adventure" ),
      Genres(id: 16 ,name: "Animation" ),
      Genres(id: 35 ,name: "Comedy" ),
      Genres(id: 80 ,name: "Crime" ),
      Genres(id: 99 ,name: "Documentary" ),
      Genres(id: 18 ,name: "Drama" ),
      Genres(id: 10751 ,name: "Family" ),
      Genres(id: 14 ,name: "Fantasy" ),
      Genres(id: 36 ,name: "History" ),
      Genres(id: 27 ,name: "Horror" ),
      Genres(id: 10402 ,name: "Music" ),
      Genres(id: 9648 ,name: "Mystery" ),
      Genres(id: 10749 ,name: "Romance" ),
      Genres(id: 878 ,name: "Science Fiction" ),
      Genres(id: 10770 ,name: "TV Movie" ),
      Genres(id: 53 ,name: "Thriller" ),
      Genres(id: 10752 ,name: "War" ),
      Genres(id: 37 ,name: "Western" ),
    ];
}
}








