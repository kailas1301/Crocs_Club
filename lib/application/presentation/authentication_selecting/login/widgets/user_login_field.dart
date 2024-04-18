import 'package:crocs_club/application/business_logic/login/bloc/login_bloc.dart';
import 'package:crocs_club/application/presentation/authentication_selecting/signup/sign_up_screen.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginWidget extends StatelessWidget {
  const UserLoginWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Crocs logo
            Image.asset(
              'assets/images/CROCS.png',
              height: 200,
              width: 200,
            ),
            kSizedBoxH20, // Spacing
            // Email text field
            TextFormFieldWidget(
              labelText: 'E-mail',
              controller: emailController,
              hintText: 'Enter your E-mail',
              prefixIcon: Icons.email,
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'E-mail is required';
                }
                final emailRegex = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  caseSensitive: false,
                  multiLine: false,
                );
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid E-mail';
                }
                return null; // Valid
              },
            ),
            kSizedBoxH20, // Spacing
            // Password text field
            TextFormFieldWidget(
              labelText: 'Password',
              obscureText: true,
              prefixIcon: Icons.security,
              controller: passwordController,
              hintText: 'Enter your Password',
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null; // Valid
              },
            ),
            kSizedBoxH20, // Spacing
            // Log in button
            ElevatedButtonWidget(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Validate form fields
                  // If validation succeeds, trigger login event
                  BlocProvider.of<LoginBloc>(context).add(
                    LoginButtonPressed(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                }
              },
              buttonText: 'Log in',
            ),
            kSizedBoxH20, // Spacing
            // New user registration button
            TextButton(
              onPressed: () {
                // Navigate to sign up screen when "New User? Register Here" is clicked
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SignUpScrn(),
                ));
              },
              child: const Text('New User? Register Here'),
            ),
          ],
        ),
      ),
    );
  }
}
