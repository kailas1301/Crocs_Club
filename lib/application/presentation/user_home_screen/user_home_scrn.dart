import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/application/presentation/favourites_page/favourite_page.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});
  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    String greeting = getGreeting(currentTime.hour);
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavouriteScreen(),
                ));
              },
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
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return Text(
                    '$greeting, ${state.profileData['name']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text(
                    greeting,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
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
      buildOfferItem('', '', Colors.red),
      buildOfferItem('', '', const Color.fromARGB(255, 61, 99, 205)),
      buildOfferItem('', '', const Color.fromARGB(255, 122, 155, 37)),
    ],
  );
}

Widget buildOfferItem(String imageUrl, String offerText, Color color) {
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
          offset: const Offset(2, 2), // changes position of shadow
        ),
      ],
    ),
    child: const Column(
      children: [],
    ),
  );
}
