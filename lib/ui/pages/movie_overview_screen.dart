import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/movies_bloc.dart';

class MovieOverviewScreen extends StatefulWidget {
  final int indexOfMovie;

  const MovieOverviewScreen({Key? key, required this.indexOfMovie})
      : super(key: key);

  @override
  _MovieOverviewScreenState createState() => _MovieOverviewScreenState();
}

class _MovieOverviewScreenState extends State<MovieOverviewScreen> {
  int get index => widget.indexOfMovie;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.movies[index].title),
            ),
            body: ListView(
              children: [
                _movieOverview(state),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Column _movieOverview(MoviesLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _movieImage(state),
        _movieRating(state),
        SizedBox(height: 8),
        _movieTitle(state),
        SizedBox(height: 8),
        _movieYear(state),
        _movieCrew(state),
        SizedBox(height: 24),
      ],
    );
  }

  Container _movieCrew(MoviesLoaded state) {
    return Container(
      width: 120,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Crew: ',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: state.movies[index].crew,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ))
          ],
        ),
      ),
    );
  }

  RichText _movieYear(MoviesLoaded state) {
    return RichText(
      text: TextSpan(
        text: 'Year: ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: state.movies[index].year,
              style: const TextStyle(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  Container _movieTitle(MoviesLoaded state) {
    return Container(
      width: 220,
      child: Text(
        state.movies[index].title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _movieRating(MoviesLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        Text(
          '${state.movies[index].imDbRating} / 10',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 12,
        )
      ],
    );
  }

  Widget _movieImage(MoviesLoaded state) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      width: 160,
      height: 220,
      child: CachedNetworkImage(
        imageUrl: state.movies[index].image,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),

      // Image.network(
      //   state.movies[index].image,
      //   loadingBuilder: (context, Widget child, loadingProgress) {
      //     if (loadingProgress == null) return child;
      //     return Center(
      //       child: CircularProgressIndicator(
      //         value: loadingProgress.expectedTotalBytes != null
      //             ? loadingProgress.cumulativeBytesLoaded /
      //                 loadingProgress.expectedTotalBytes!
      //             : null,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
