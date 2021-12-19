import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_api/ui/pages/bloc/movies_bloc.dart';

import 'movie_overview_screen.dart';

class MoviesListScreen extends StatefulWidget {
  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  void initState() {
    _getMoviesFromAPI();
    super.initState();
  }

  void _getMoviesFromAPI() {
    BlocProvider.of<MoviesBloc>(context).add(GetMoviesFromAPI());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'IMDb Best Movies',
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoaded) {
              return ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieOverviewScreen(
                                    indexOfMovie: index,
                                  ))),
                      child: ListTile(
                        leading: Text(
                          '${index + 1}.',
                          style: const TextStyle(fontSize: 16),
                        ),
                        title: AutoSizeText(
                          state.movies[index].title,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
