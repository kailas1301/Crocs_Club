import 'package:crocs_club/application/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GnavWidget extends StatelessWidget {
  const GnavWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GNav(
        color: kDarkGreyColour,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        gap: 6,
        activeColor: kwhiteColour,
        iconSize: 20,
        textSize: 9,
        tabBackgroundColor: kAppPrimaryColor,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 250),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () => context.read<NavbarBloc>().add(HomePressed()),
          ),
          GButton(
            icon: Icons.add_shopping_cart,
            text: 'Products',
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () => context.read<NavbarBloc>().add((ProductPressed())),
          ),
          GButton(
            icon: Icons.shopping_bag,
            text: 'Cart',
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () => context.read<NavbarBloc>().add(CartPressed()),
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () => context.read<NavbarBloc>().add(ProfilePressed()),
          ),
        ],
      ),
    );
  }
}
