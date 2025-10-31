
import 'package:family_finances/features/home/family_list.dart';
import 'package:family_finances/features/home/home_carousel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Finances'),
      ),
      body: Column(
        children: [
          const HomeCarousel(),
          const SizedBox(height: 20), // Adding some space
          const FamilyList(),
        ],
      ),
    );
  }
}
