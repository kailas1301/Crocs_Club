import 'package:crocs_club/application/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GnavWidget extends StatelessWidget {
  const GnavWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GNav(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      gap: 8,
      activeColor: const Color.fromARGB(255, 252, 253, 253),
      iconSize: 22,
      tabBackgroundColor: const Color.fromARGB(255, 104, 103, 103),
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
    );
  }
}
