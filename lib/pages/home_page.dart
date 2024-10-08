import 'package:flutter/material.dart';
import 'package:showtime/pages/favs_page.dart';
import 'package:showtime/pages/movies_page.dart';
import 'package:showtime/pages/series_page.dart';
import 'package:showtime/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;

  List<Widget> widgetList = const [MoviesPage(), SeriesPage(), FavsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          height: 40,
        ),
        centerTitle: true,
      ),

      body: IndexedStack(
        index: myIndex,
        children: widgetList,
      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myIndex,
        backgroundColor: Colours.scaffoldBgColor.withOpacity(0.6),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.video_camera_back), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Series'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
    );
  }
}
