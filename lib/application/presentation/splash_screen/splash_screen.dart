import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crocs_club/application/business_logic/Splash/bloc/splash_bloc.dart';
import 'package:crocs_club/application/business_logic/Splash/bloc/splash_event.dart';
import 'package:crocs_club/application/business_logic/Splash/bloc/splash_state.dart';
import 'package:crocs_club/application/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/application/presentation/on_boarding/on_boarding.dart';
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: Image.asset('assets/images/CROCS (2).png'),
      splashIconSize: 300,
      nextScreen: BlocProvider<SplashBloc>(
        create: (context) => SplashBloc()..add(SetSplash()),
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) async {
            if (state is SplashLoadedState) {
              final userLoggedInToken = await getToken();
              if (userLoggedInToken == '') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavBar()),
                );
              }
            }
          },
          builder: (context, state) {
            return Container(); // Placeholder widget while waiting for state
          },
        ),
      ),
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000, // Adjust duration as needed
    );
  }
}
