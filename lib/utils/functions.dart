import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> userlogout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', ''); // Set token to empty string
  print('Logged out successfully!');
}

Future<String?> getToken() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  } catch (e) {
    print('Error fetching token: $e');
    throw Exception('Failed to get access token: $e');
  }
}

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', token); // Set token to empty string
  print('Token saved successfully!');
}

void showCustomSnackbar(
    BuildContext context, String text, Color backgroundcolor, Color textcolor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 3),
      content: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
      backgroundColor: backgroundcolor,
    ),
  );
}

String getGreeting(int hour) {
  if (hour < 12) {
    return 'Good morning';
  } else if (hour < 18) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
