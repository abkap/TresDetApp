import 'package:flutter/material.dart';

class DetectedImageScreen extends StatelessWidget {
  const DetectedImageScreen({super.key, required this.imgUrl});

  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Image(
        image: NetworkImage(imgUrl),
      ),
    );
  }
}
