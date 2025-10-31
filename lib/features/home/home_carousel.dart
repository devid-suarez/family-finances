
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/carousel_image_1.jpg',
      'assets/images/carousel_image_2.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(minutes: 3),
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imgList.map((item) {
        return Center(
          child: Image.asset(
            item,
            fit: BoxFit.cover,
            width: 1000,
          ),
        );
      }).toList(),
    );
  }
}
