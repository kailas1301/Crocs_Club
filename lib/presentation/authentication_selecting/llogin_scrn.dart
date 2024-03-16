import 'package:crocs_club/utils/constants.dart';
import 'package:crocs_club/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                // Crocs logo
                Image.asset(
                  'assets/images/pngegg.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20.0), // Spacing

                // Email text field
                TextFormFieldWidget(
                  controller: emailController,
                  labelText: 'E-mail',
                  prefixIcon: Icons.email,
                  errorText: 'Please enter valid E-mail',
                ),
                kSizedBoxH20, // Spacing

                // Password text field
                TextFormFieldWidget(
                    controller: passwordController,
                    labelText: 'Password',
                    errorText: 'Please enter a valid password'),
                const SizedBox(height: 20.0), // Spacing

                // Login button
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // // Trigger login event in your Bloc
                      // BlocProvider.of<LoginBloc>(context)
                      //     .add(LoginButtonPressed(
                      //   email: emailController.text,
                      //   password: passwordController.text,
                      // ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                  ),
                  child: const Text('Login'),
                ),

                const SizedBox(height: 15.0), // Spacing

                // Forgot password link
                TextButton(
                  onPressed: () {
                    // Handle forgot password functionality
                  },
                  child: const Text('Forgot Password?'),
                ),

                const SizedBox(height: 20.0), // Spacing

                // New user registration button
                TextButton(
                  onPressed: () {
                    // Handle new user registration navigation
                  },
                  child: const Text('New User? Register Here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
