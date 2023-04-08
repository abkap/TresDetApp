import 'package:flutter/material.dart';

class TabBarText extends StatelessWidget {
  const TabBarText(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
