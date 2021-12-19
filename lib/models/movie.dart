import 'dart:convert';

class Movie {
  final String id;
  final String title;
  final String year;
  final String image;
  final String crew;
  final String imDbRating;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.image,
    required this.crew,
    required this.imDbRating,
  });

  // factory Movie.fromJson(Map<String, dynamic> json) {
  //   return Movie(
  //     id: json['id'],
  //     title: json['title'],
  //     year: json['year'],
  //     image: json['image'],
  //     crew: json['crew'],
  //     imDbRating: json['imDbRating'],
  //   );
  // }
  //
  // Map<String, dynamic> toJson(List<Movie> movies) => {'items': movies};

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'image': image,
      'crew': crew,
      'imDbRating': imDbRating,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      year: map['year'] ?? '',
      image: map['image'] ?? '',
      crew: map['crew'] ?? '',
      imDbRating: map['imDbRating'] ?? '',
    );
  }
}
