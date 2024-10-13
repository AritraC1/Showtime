import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showtime/pages/movies_details_page.dart';
import 'package:showtime/pages/series_details_page.dart';
import 'package:showtime/provider/movies_provider.dart';
import 'package:showtime/provider/series_provider.dart';
import 'package:showtime/utils/constants.dart';

class FavsPage extends StatelessWidget {
  const FavsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the MoviesProvider to get the favorite movies and series
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final favoriteMovies =
        moviesProvider.favoriteMovies; // List of favorite movies

    final seriesProvider = Provider.of<SeriesProvider>(context);
    final favoriteSeries =
        seriesProvider.favoriteSeries; // List of favorite series

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 2,
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 2,
              ),
              itemCount: favoriteMovies.length + favoriteSeries.length,
              // Total count
              itemBuilder: (context, index) {
                // Determine if the item is a movie or series
                if (index < favoriteMovies.length) {
                  // Its a fav movie
                  final movie = favoriteMovies[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to movie details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoviesDetailsPage(movie: movie),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${Constants.imagePath}${movie.posterPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                } else {
                  // It's a favorite series
                  final seriesIndex =
                      index - favoriteMovies.length; // Adjust index for series
                  final tv = favoriteSeries[seriesIndex];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to series details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeriesDetailsPage(tv: tv),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${Constants.imagePath}${tv.posterPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
