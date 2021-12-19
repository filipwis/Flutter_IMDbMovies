import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_api/api/api_service.dart';
import 'package:movies_api/models/movie.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final ApiService _apiService;
  MoviesBloc(this._apiService) : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if (event is GetMoviesFromAPI) {
      yield MoviesLoading();
      try {
        final List<Movie> movies = await _apiService.getMovies();
        yield MoviesLoaded(movies: movies);
      } catch (e) {
        print(e);
      }
    }
  }
}
