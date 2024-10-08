import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showtime/pages/home_page.dart';
import 'package:showtime/provider/movies_provider.dart';
import 'package:showtime/utils/colors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoviesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
      ),
      home: const HomePage(),
    );
  }
}
