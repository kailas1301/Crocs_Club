import 'package:crocs_club/business_logic/login/bloc/login_bloc.dart';
import 'package:crocs_club/presentation/authentication_selecting/sign_up_screen.dart';
import 'package:crocs_club/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/utils/constants.dart';
import 'package:crocs_club/utils/functions.dart';
import 'package:crocs_club/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          // Show a progress indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginSuccessful) {
          Navigator.pop(context);
          showCustomSnackbar(context, 'Signed up Successfully',
              Color.fromARGB(255, 81, 179, 99), Colors.black);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BottomNavBar(),
              ),
              (route) => false);
        } else if (state is LoginError) {
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
                  // Crocs logo
                  Image.asset(
                    'assets/images/pngegg.png',
                    height: 100,
                    width: 100,
                  ),
                  kSizedBoxH20,
                  // Email text field
                  TextFormFieldWidget(
                    controller: emailController,
                    hintText: 'E-mail',
                    prefixIcon: Icons.email,
                    errorText: 'Please enter valid E-mail',
                  ),
                  kSizedBoxH20, // Spacing
                  // Password text field
                  TextFormFieldWidget(
                      obscureText: true,
                      prefixIcon: Icons.security,
                      controller: passwordController,
                      hintText: 'Password',
                      errorText: 'Please enter a valid password'),
                  kSizedBoxH20, // Spacing
                  ElevatedButtonWidget(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginButtonPressed(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      buttonText: 'Log in'),
                  kSizedBoxH20, // Spacing

                  // Forgot password link
                  // TextButton(
                  //   onPressed: () {
                  //     // Handle forgot password functionality
                  //   },
                  //   child: const Text('Forgot Password?'),
                  // ),
                  kSizedBoxH20, // Spacing

                  // New user registration button
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpScrn(),
                      ));
                    },
                    child: const Text('New User? Register Here'),
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
