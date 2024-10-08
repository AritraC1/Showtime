import 'package:flutter/material.dart';

class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

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
