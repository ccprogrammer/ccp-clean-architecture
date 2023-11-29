import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  static const route = '/favorites';

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: Text('Favorites'),
      ),
    );
  }
}