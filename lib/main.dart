import 'package:crocs_club/application/business_logic/Splash/bloc/splash_bloc.dart';
import 'package:crocs_club/application/business_logic/address/bloc/adressbloc_bloc.dart';
import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/checkout/bloc/checkout_bloc.dart';
import 'package:crocs_club/application/business_logic/coupon/bloc/coupon_bloc.dart';
import 'package:crocs_club/application/business_logic/login/bloc/login_bloc.dart';
import 'package:crocs_club/application/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/application/business_logic/search/bloc/search_bloc.dart';
import 'package:crocs_club/application/business_logic/sign_up/bloc/signup_bloc.dart';
import 'package:crocs_club/application/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:crocs_club/application/presentation/splash_screen/splash_screen.dart';
import 'package:crocs_club/data/services/get_checkout/get_checkout.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late double screenWidth;
late double screenHeight;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CheckOutServices checkoutRepository = CheckOutServices();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => NavbarBloc()),
        BlocProvider(create: (_) => SignupBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => AdressblocBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => WishlistBloc()),
        BlocProvider(create: (_) => SearchBloc()),
        BlocProvider(create: (_) => CheckoutBloc(checkoutRepository)),
        BlocProvider(create: (_) => CouponBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
            primaryColor:
                kAppPrimaryColor // Or a custom blue color using Color(0xFFyourBlueValue)
            ),
      ),
    );
  }
}
