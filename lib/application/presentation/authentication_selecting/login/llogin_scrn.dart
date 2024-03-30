import 'package:crocs_club/application/business_logic/login/bloc/login_bloc.dart';
import 'package:crocs_club/application/presentation/authentication_selecting/login/widgets/user_login_field.dart';
import 'package:crocs_club/application/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Form key to handle form validation
    final formKey = GlobalKey<FormState>();
    // Text editing controllers for email and password fields
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          // Show a progress indicator while logging in
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginSuccessful) {
          // Hide progress indicator when login successful
          Navigator.pop(context);
          // Show success message
          showCustomSnackbar(
              context, 'Successfully Logged in', kGreenColour, kblackColour);
          // Navigate to home screen after successful login
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
              (route) => false);
        } else if (state is LoginError) {
          // Hide progress indicator when login fails
          Navigator.pop(context);
          // Show error message
          showCustomSnackbar(context, state.error, Colors.red,
              Colors.black); // Close progress dialog (if shown)
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
