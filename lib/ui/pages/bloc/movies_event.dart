part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class GetMoviesFromAPI extends MoviesEvent {}
