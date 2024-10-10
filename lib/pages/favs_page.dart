import 'package:flutter/material.dart';

class FavsPage extends StatelessWidget {
  const FavsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: 51,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white10,
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
