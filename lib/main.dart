
import 'package:boardgamesmsf/ui/movies/list-movies.dart';
import 'package:flutter/material.dart';

import 'di/setup-di.dart';

void main() {
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(235, 152, 78, 1)),
        useMaterial3: true,
      ),
      home: ListMovies(),
    );
  }
}