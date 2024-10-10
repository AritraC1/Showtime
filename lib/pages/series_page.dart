import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showtime/pages/series_details_page.dart';
import 'package:showtime/provider/series_provider.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key});

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch movies when the widget is initialized
    Future.microtask(() => Provider.of<SeriesProvider>(context, listen: false)
        .getTrendingSeries());

    // Add listener to scroll controller to detect when we reach the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // Load more movies when scrolled to the bottom
        Provider.of<SeriesProvider>(context, listen: false)
            .getTrendingSeries(loadMore: true);
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
            child: Consumer<SeriesProvider>(
              builder: (context, seriesProvider, child) {
                if (seriesProvider.trending.isEmpty &&
                    seriesProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  controller: _scrollController,
                  itemCount: seriesProvider.trending.length,
                  itemBuilder: (context, index) {
                    if (index == seriesProvider.trending.length) {
                      return const Center(
                        child: CircularProgressIndicator(), // Loading indicator
                      );
                    }

                    final tv = seriesProvider.trending[index];

                    return GestureDetector(
                      onTap: () {
                        // Navigate to Movies Details Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeriesDetailsPage(tv: tv),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
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
