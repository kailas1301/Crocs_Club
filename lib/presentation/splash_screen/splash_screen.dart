import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crocs_club/business_logic/Splash/bloc/splash_bloc.dart';
import 'package:crocs_club/business_logic/Splash/bloc/splash_event.dart';
import 'package:crocs_club/business_logic/Splash/bloc/splash_state.dart';
import 'package:crocs_club/presentation/authentication_selecting/llogin_scrn.dart';
import 'package:crocs_club/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/splash.png'),
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
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
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
