import 'package:crocs_club/utils/functions.dart';
import 'package:crocs_club/utils/widgets/elevatedbutton_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButtonWidget(
              onPressed: () {
                userlogout(context);
                showCustomSnackbar(context, 'Successfully logged out',
                    Colors.white, Colors.black);
              },
              buttonText: 'Log Out')),
    );
  }
}
