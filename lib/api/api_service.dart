import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';
import 'package:movies_api/constants/constants.dart';
import 'package:movies_api/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class ApiService {
  Future<List<Movie>> getMovies() async {
    final uri =
        Uri.http('imdb-api.com', 'en/API/Top250Movies/${Constants.API_KEY}');
    List<Movie> listOfMovies = [];

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var box = await Hive.openBox('movies');
        box.put('items', response.body);
        listOfMovies = json
            .decode(response.body)['items']
            .map<Movie>((data) => Movie.fromJson(data))
            .toList();
      }
    } else {
      var box = await Hive.openBox('movies');
      var items = box.get('items');
      listOfMovies = json
          .decode(items)['items']
          .map<Movie>((data) => Movie.fromJson(data))
          .toList();
    }
    return listOfMovies;
  }
}
