import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  FullScreen({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.network(imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
