import 'package:crocs_club/application/presentation/authentication_selecting/login/llogin_scrn.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Function to log out the user by clearing the access token from SharedPreferences
Future<void> userlogout(BuildContext context) async {
  // Show confirmation dialog
  bool confirmLogout = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: AlertDialog(
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButtonWidget(
                  buttonText: 'Yes',
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Return true when confirmed
                  },
                ),
                ElevatedButtonWidget(
                  buttonText: 'No',
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Return false when canceled
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
  // If user confirms logout, proceed with logout process
  if (confirmLogout == true) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', ''); // Set token to empty string
    print('Logged out successfully!');
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}

// Function to show a custom Snackbar with specified text and colors
void showCustomSnackbar(
    BuildContext context, String text, Color backgroundcolor, Color textcolor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
      backgroundColor: backgroundcolor,
    ),
  );
}

// Function to return a greeting based on the time of the day
String getGreeting(int hour) {
  if (hour < 12) {
    return 'Good morning';
  } else if (hour < 18) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
