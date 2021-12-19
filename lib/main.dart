import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_api/api/api_service.dart';
import 'package:movies_api/ui/pages/bloc/movies_bloc.dart';
import 'package:movies_api/ui/pages/movies_list_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MoviesBloc(_apiService),
      child: MaterialApp(
        title: 'IMDb Ranking',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'Montserrat',
        ),
        home: MoviesListScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
