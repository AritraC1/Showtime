import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showtime/models/movies.dart';
import 'package:showtime/provider/movies_provider.dart';
import 'package:showtime/provider/videos_provider.dart';
import 'package:showtime/utils/colors.dart';
import 'package:showtime/utils/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesDetailsPage extends StatelessWidget {
  final Movies movie;

  const MoviesDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const BackButton(),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${Constants.imagePath}${movie.backdropPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Fav Button
                      IconButton(
                        onPressed: () {
                          Provider.of<MoviesProvider>(context, listen: false)
                              .toggleFavorite(movie);
                        },
                        icon: Icon(
                          Provider.of<MoviesProvider>(context).isFavorite(movie)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Provider.of<MoviesProvider>(context).isFavorite(movie)
                              ? Colors.red // **Red color if favorite**
                              : Colors.white70,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    movie.overview,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Release Date: ',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              movie.releaseDate,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const Text(
                              'Rating: ',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text('${movie.rating.toStringAsFixed(1)}/10'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Trailers Of the Movie
                  const Text(
                    "Trailers and Clips",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Consumer<VideosProvider>(
                    builder: (context, videosProvider, child) {
                      if (videosProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (videosProvider.trailers.isEmpty) {
                        return const Text('No trailers available');
                      }

                      return CarouselSlider(
                        items: videosProvider.trailers.map((trailer) {
                          // Build the trailer item using the 'key' for a video
                          final videoKey = trailer.key;
                          final videoUrl =
                              'https://www.youtube.com/watch?v=$videoKey';

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                // Display YouTube trailer using the video key
                                Expanded(
                                  child: YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: videoKey,
                                      flags: const YoutubePlayerFlags(
                                        autoPlay: false,
                                        mute: false,
                                      ),
                                    ),
                                    showVideoProgressIndicator: true,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  trailer.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          autoPlay: false,
                          height: 180,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
