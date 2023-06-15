import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../pages/fullscreen_page.dart';

// ignore: must_be_immutable
class PinterestStyleGridView extends StatelessWidget {
  PinterestStyleGridView({super.key, required this.images});
  var images;
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      FullScreen(imageUrl: images[index]['url'])));
            },
            child: Image.network(images[index]['url']),
          ),
        );
      },
    );
  }
}
