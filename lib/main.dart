import 'package:crocs_club/application/business_logic/Splash/bloc/splash_bloc.dart';
import 'package:crocs_club/application/business_logic/login/bloc/login_bloc.dart';
import 'package:crocs_club/application/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/application/business_logic/sign_up/bloc/signup_bloc.dart';
import 'package:crocs_club/application/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => NavbarBloc()),
        BlocProvider(create: (_) => SignupBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => ProfileBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
