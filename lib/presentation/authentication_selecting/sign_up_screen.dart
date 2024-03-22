import 'package:crocs_club/business_logic/sign_up/bloc/signup_bloc.dart';
import 'package:crocs_club/presentation/authentication_selecting/llogin_scrn.dart';
import 'package:crocs_club/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/utils/constants.dart';
import 'package:crocs_club/utils/functions.dart';
import 'package:crocs_club/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          // Show a progress indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is SignUpSuccessful) {
          Navigator.pop(context);
          showCustomSnackbar(context, 'Signed up Successfully',
              Color.fromARGB(255, 81, 179, 99), Colors.black);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BottomNavBar(),
              ),
              (route) => false);
        } else if (state is SignUpError) {
          Navigator.pop(context);
          showCustomSnackbar(context, state.error, Colors.red,
              Colors.black); // Close progress dialog (if shown)
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name text field
                  TextFormFieldWidget(
                    controller: nameController,
                    hintText: 'Name',
                    prefixIcon: Icons.person,
                    errorText: 'Please enter your name',
                  ),
                  kSizedBoxH20, // Spacing
                  // Email text field
                  TextFormFieldWidget(
                    controller: emailController,
                    hintText: 'E-mail',
                    prefixIcon: Icons.email,
                    errorText: 'Please enter valid E-mail',
                  ),
                  kSizedBoxH20, // Spacing
                  // Phone number text field
                  TextFormFieldWidget(
                    controller: phoneController,
                    hintText: 'Phone Number',
                    prefixIcon: Icons.phone,
                    errorText: 'Please enter valid phone number',
                  ),
                  kSizedBoxH20, // Spacing
                  // Password text field
                  TextFormFieldWidget(
                    obscureText: true,
                    prefixIcon: Icons.security,
                    controller: passwordController,
                    hintText: 'Password',
                    errorText: 'Please enter a valid password',
                  ),
                  kSizedBoxH20, // Spacing
                  // Confirm Password text field
                  TextFormFieldWidget(
                    obscureText: true,
                    prefixIcon: Icons.security,
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    errorText: 'Passwords do not match',
                  ),
                  kSizedBoxH30, // Spacing
                  ElevatedButtonWidget(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupButtonPressed(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                          ),
                        );
                      }
                    },
                    buttonText: 'Sign Up',
                  ),
                  kSizedBoxH10, // Spacing
                  // Already have an account link
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    child: const Text('Already have an account? Log in'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
