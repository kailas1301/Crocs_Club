// Function to fetch the access token from SharedPreferences
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  } catch (e) {
    print('Error fetching token: $e');
    throw Exception('Failed to get access token: $e');
  }
}

Future<int?> getUserId() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('UserId') ?? 0;
  } catch (e) {
    print('Error fetching token: $e');
    throw Exception('Failed to get access token: $e');
  }
}

// Function to save the access token to SharedPreferences
Future<void> saveToken(String token) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token); // Set token to provided value
    print('Token saved successfully!');
  } catch (e) {
    print('Error saving token: $e');
    throw Exception('Failed to save access token: $e');
  }
}

// Function to save the access token to SharedPreferences
Future<void> saveUserId(int id) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('UserId', id); // Set token to provided value
    print('Id saved successfully!');
  } catch (e) {
    print('Error saving Id: $e');
    throw Exception('Failed to save Id: $e');
  }
}
