import 'package:flutter/material.dart';

class Searchbarwidget extends StatelessWidget {
  const Searchbarwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: 'search...'),
    );
  }
}
