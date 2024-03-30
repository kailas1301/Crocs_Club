import 'package:crocs_club/application/business_logic/sign_up/bloc/signup_bloc.dart';
import 'package:crocs_club/application/presentation/authentication_selecting/login/llogin_scrn.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            keyboardType: TextInputType.name,
            controller: nameController,
            hintText: 'Name',
            prefixIcon: Icons.person,
            validatorFunction: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              if (value.length < 3) {
                return 'Nme must be at least 3 characters long';
              }
              return null; // Valid
            },
          ),
          kSizedBoxH20, // Spacing
          TextFormFieldWidget(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            hintText: 'E-mail',
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
          TextFormFieldWidget(
            maxLength: 10,
            keyboardType: TextInputType.number,
            controller: phoneController,
            hintText: 'Phone Number',
            prefixIcon: Icons.phone,
            validatorFunction: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              if (value.length != 10) {
                return 'Phone number must be 10 digits';
              }
              return null; // Valid
            },
          ),
          kSizedBoxH20, // Spacing
          TextFormFieldWidget(
            obscureText: true,
            prefixIcon: Icons.security,
            controller: passwordController,
            hintText: 'Password',
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
          TextFormFieldWidget(
            obscureText: true,
            prefixIcon: Icons.security,
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            validatorFunction: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirm Password is required';
              }
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null; // Valid
            },
          ),
          kSizedBoxH30, // Spacing
          ElevatedButtonWidget(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Validate the form fields
                // If validation succeeds, trigger sign up event
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
              // Navigate to login screen when "Already have an account?" is clicked
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
            },
            child: const Text('Already have an account? Log in'),
          ),
        ],
      ),
    );
  }
}
