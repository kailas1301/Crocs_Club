import 'package:crocs_club/application/business_logic/sign_up/bloc/signup_bloc.dart';
import 'package:crocs_club/application/presentation/authentication_selecting/signup/widgets/signupform_widget.dart';
import 'package:crocs_club/application/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpScrn extends StatelessWidget {
  const SignUpScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          // Show loading dialog when sign up is in progress
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: kAppPrimaryColor,
                      size: 40,
                    ),
                  ));
        } else if (state is SignUpSuccessful) {
          Navigator.pop(context);
          // Show success message if sign up is successfull
          showCustomSnackbar(
              context, 'Signed up Successfully', kGreenColour, kwhiteColour);
          // Navigate to the home screen after successful sign up
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
              (route) => false);
        } else if (state is SignUpError) {
          // Hide loading dialog when sign up fails
          Navigator.pop(context);
          // Show error message
          showCustomSnackbar(context, state.error, kwhiteColour,
              kblackColour); // Close progress dialog (if shown)
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kwhiteColour,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SignUpFormWidget(
                  formKey: formKey,
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController),
            ),
          ),
        ),
      ),
    );
  }
}
