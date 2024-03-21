import 'package:crocs_club/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocs_club/presentation/offers_and_coupons/offers_coupons_add.dart';
import 'package:crocs_club/presentation/products/products.dart';
import 'package:crocs_club/presentation/profile_screen/profile_screen.dart';
import 'package:crocs_club/presentation/user_home_screen/user_home_scrn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavbarBloc>(
      // Wrap with BlocProvider
      create: (context) => NavbarBloc(),
      child: BlocBuilder<NavbarBloc, NavbarState>(
        builder: (context, state) {
          Widget currentScreen = const UserHome(); // Default screen

          if (state is HomeSelected) {
            currentScreen = const UserHome();
          } else if (state is ProductScreenSelected) {
            currentScreen = const ProductsScreen();
          } else if (state is CartScreenSelected) {
            currentScreen = const CartScreen();
          } else if (state is ProfileScreenSelected) {
            currentScreen = const ProfileScreen();
          }

          return Scaffold(
            body: currentScreen, // Set body based on state
            bottomNavigationBar: GNav(
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
                  onPressed: () =>
                      context.read<NavbarBloc>().add(HomePressed()),
                ),
                GButton(
                  icon: Icons.add_shopping_cart,
                  text: 'Products',
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () =>
                      context.read<NavbarBloc>().add((ProductPressed())),
                ),
                GButton(
                  icon: Icons.shopping_bag,
                  text: 'Cart',
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () =>
                      context.read<NavbarBloc>().add(CartPressed()),
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () =>
                      context.read<NavbarBloc>().add(ProfilePressed()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
