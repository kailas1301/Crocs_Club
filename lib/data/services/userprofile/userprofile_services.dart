import 'dart:convert';
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/profile_model.dart';
import 'package:http/http.dart' as http;

class UserProfileServices {
  String baseUrl = 'https://crocs.crocsclub.shop';
// Function to fetch user profile with provided token
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final url = Uri.parse('$baseUrl/user/profile/details');
      final token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        Map<String, dynamic> userProfile = body["data"];
        return userProfile;
      } else {
        print('Error fetching user profile: ${response.statusCode}');
        final data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  Future<String> updateUserProfile(UserProfile profile) async {
    try {
      final token = await getToken();
      final url = Uri.parse('https://crocs.crocsclub.shop/user/profile/edit/');
      final response = await http.patch(
        url,
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 201) {
        return 'success';
      } else {
        return 'error';
      }
    } catch (e) {
      throw Exception('Error updating user profile: $e');
    }
  }

  Future<Map<String, dynamic>> changePassword(
    ChangePasswordPayload payload,
  ) async {
    final token = await getToken();
    final url = Uri.parse(
        'https://crocs.crocsclub.shop/user/profile/security/change-password');
    final response = await http.put(
      url,
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to change user password');
    }
  }
}
