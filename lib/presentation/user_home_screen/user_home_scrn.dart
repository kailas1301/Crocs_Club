import 'package:crocs_club/utils/constants.dart';
import 'package:crocs_club/utils/functions.dart';
import 'package:crocs_club/utils/widgets/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});
  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    String greeting = getGreeting(currentTime.hour);
    String username = "username";
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
              icon: const Icon(Icons.menu_outlined),
            ),
          ),
          title: Text('CROCS CLUB',
              style: GoogleFonts.roboto(
                fontSize: 20, // Adjust the fontSize as needed
                fontWeight: FontWeight.w700, // Adjust the fontWeight as needed
              )),
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '$greeting, $username',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          kSizedBoxH20,
          buildCarouselSlider(),
        ],
      ),
      drawer: const DrawerScreen(),
    );
  }
}

Widget buildCarouselSlider() {
  return CarouselSlider(
    options: CarouselOptions(
      height: 200,
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
      buildOfferItem('', ''),
      buildOfferItem('', ''),
      buildOfferItem('', ''),
    ],
  );
}

Widget buildOfferItem(String imageUrl, String offerText) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(2, 2), // changes position of shadow
        ),
      ],
    ),
    child: const Column(
      children: [
        Center(child: Text('offer')),
      ],
    ),
  );
}
