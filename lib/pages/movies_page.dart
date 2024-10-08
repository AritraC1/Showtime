import 'package:flutter/material.dart';
import 'package:showtime/models/movies.dart';
import '../api/api.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                  );
                },
                itemCount: 51,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
