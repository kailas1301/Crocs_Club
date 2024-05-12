import 'package:carousel_slider/carousel_slider.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';

Widget buildCarouselSlider() {
  return CarouselSlider(
    options: CarouselOptions(
      height: screenHeight * .25,
      aspectRatio: 16 / 9,
      viewportFraction: 0.9,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    ),
    items: [
      buildCarouselItem('assets/images/1.jpg', Colors.red),
      buildCarouselItem(
          'assets/images/2.jpg', const Color.fromARGB(255, 61, 99, 205)),
      buildCarouselItem(
          'assets/images/3.jpg', const Color.fromARGB(255, 122, 155, 37)),
    ],
  );
}

Widget buildCarouselItem(String imageUrl, Color color) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(2, 2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: imageUrl.isNotEmpty
          ? Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            )
          : const Center(child: CircularProgressIndicator()), // Placeholder
    ),
  );
}
