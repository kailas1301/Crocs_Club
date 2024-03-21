import 'package:crocs_club/presentation/authentication_selecting/llogin_scrn.dart';
import 'package:crocs_club/utils/constants.dart';
import 'package:crocs_club/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
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
                      // Perform signup logic
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
    );
  }
}
