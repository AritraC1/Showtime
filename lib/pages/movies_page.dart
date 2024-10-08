import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/movies_provider.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch movies when the widget is initialized
    Future.microtask(() => Provider.of<MoviesProvider>(context, listen: false)
        .getTrendingMovies());

    // Add listener to scroll controller to detect when we reach the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // Load more movies when scrolled to the bottom
        Provider.of<MoviesProvider>(context, listen: false)
            .getTrendingMovies(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<MoviesProvider>(
              builder: (context, moviesProvider, child) {
                if (moviesProvider.trendingMovies.isEmpty &&
                    moviesProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  controller: _scrollController,
                  itemCount: moviesProvider.trendingMovies.length,
                  itemBuilder: (context, index) {
                    if (index == moviesProvider.trendingMovies.length) {
                      return const Center(
                        child: CircularProgressIndicator(), // Loading indicator
                      );
                    }

                    final movie = moviesProvider.trendingMovies[index];

                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
