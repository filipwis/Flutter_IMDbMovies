part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {
  final List<Movie>? movies;

  MoviesState({this.movies});
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  List<Movie> movies;

  MoviesLoaded({required this.movies}) : super(movies: movies);
}
