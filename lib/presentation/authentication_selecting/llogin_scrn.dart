import 'package:crocs_club/presentation/authentication_selecting/sign_up_screen.dart';
import 'package:crocs_club/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/utils/constants.dart';
import 'package:crocs_club/utils/widgets/elevatedbutton_widget.dart';
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ));
                      // if (formKey.currentState!.validate()) {
                      //   // BlocProvider.of<LoginBloc>(context)
                      //   //     .add(LoginButtonPressed(
                      //   //   email: emailController.text,
                      //   //   password: passwordController.text,
                      //   // ));
                      // }
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
    );
  }
}
