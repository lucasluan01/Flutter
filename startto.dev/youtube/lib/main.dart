import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube/blocs/favorite_bloc.dart';
import 'package:youtube/blocs/videos_bloc.dart';
import 'package:youtube/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorMap = {
      50: Colors.grey.shade50,
      100: Colors.grey.shade100,
      200: Colors.grey.shade200,
      300: Colors.grey.shade300,
      400: Colors.grey.shade400,
      500: Colors.grey.shade500,
      600: Colors.grey.shade600,
      700: Colors.grey.shade700,
      800: Colors.grey.shade800,
      900: Colors.grey.shade900,
    };

    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
      ],
      dependencies: const [],
      child: BlocProvider(
        blocs: [
          Bloc((i) => FavoriteBloc()),
        ],
        dependencies: const [],
        child: MaterialApp(
          title: 'YouTube',
          theme: ThemeData(
            primarySwatch: MaterialColor(0xFF212121, colorMap),
            scaffoldBackgroundColor: Colors.grey.shade900,
          ),
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ),
      ),
    );
  }
}
