import 'package:crocs_club/application/business_logic/login/bloc/login_bloc.dart';
import 'package:crocs_club/application/presentation/authentication_selecting/login/widgets/user_login_field.dart';
import 'package:crocs_club/application/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          // Show a progress indicator while logging in
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: kAppPrimaryColor,
                      size: 40,
                    ),
                  ));
        } else if (state is LoginSuccessful) {
          Navigator.pop(context);
          showCustomSnackbar(
              context, 'Successfully Logged in', kGreenColour, kblackColour);
          // Navigate to home screen after successful login
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
              (route) => false);
        } else if (state is LoginError) {
          Navigator.pop(context);
          showCustomSnackbar(context, state.error, kRedColour, kwhiteColour);
        }
      },
      child: Scaffold(
        backgroundColor: kwhiteColour,
        body: Center(
          child: UserLoginWidget(
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController),
        ),
      ),
    );
  }
}
