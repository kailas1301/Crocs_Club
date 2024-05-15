import 'package:crocs_club/application/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocs_club/application/presentation/bottom_nav_bar/widgets/gnav_widget.dart';
import 'package:crocs_club/application/presentation/cart_screen/cartscreen.dart';
import 'package:crocs_club/application/presentation/products/products.dart';
import 'package:crocs_club/application/presentation/profile_screen/profile_screen.dart';
import 'package:crocs_club/application/presentation/user_home_screen/user_home_scrn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavbarBloc>(
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
          return SafeArea(
            child: Scaffold(
              body: currentScreen,
              bottomNavigationBar: const GnavWidget(),
            ),
          );
        },
      ),
    );
  }
}
