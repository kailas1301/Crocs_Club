import 'dart:convert';
import 'package:crocs_club/data/models/login_model.dart';
import 'package:crocs_club/data/models/signup_model.dart';
import 'package:crocs_club/utils/functions.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static const String _baseUrl = 'http://10.0.2.2:8080';
  static const String _signupEndpoint = '/user/signup';
  static const String _loginEndpoint = '/user/login';

  Future<String> signup(SignUpRequest signupRequest) async {
    final url = Uri.parse('$_baseUrl$_signupEndpoint');
    final body = jsonEncode(signupRequest.toJson());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Handle successful signup (potentially parse response data)
      print('Signup successful!');
      final data = jsonDecode(response.body);
      final token = data['data']['Token'];
      saveToken(token);
      return 'success';
    } else {
      final data = jsonDecode(response.body);
      String errorMessage = '';
      if (data['error'] == 'user already exist, sign in') {
        errorMessage = data['error'];
      } else {
        errorMessage = data['message'];
      }
      print(errorMessage);
      print('Signup failed with status code: ${response.statusCode}');
      return errorMessage;
    }
  }

  Future<String> login(LoginRequest loginRequest) async {
    final url = Uri.parse('$_baseUrl$_loginEndpoint');
    final body = jsonEncode(loginRequest.toJson());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Handle successful signup (potentially parse response data)
      print('Signup successful!');
      final data = jsonDecode(response.body);
      final token = data['data']['Token'];
      saveToken(token);
      return 'success';
    } else {
      final data = jsonDecode(response.body);
      String errorMessage = '';
      if (data['error'] == 'user already exist, sign in') {
        errorMessage = data['error'];
      } else {
        errorMessage = data['message'];
      }

      print(errorMessage);
      print('Signup failed with status code: ${response.statusCode}');
      return errorMessage;
    }
  }

  Future<Map<String, dynamic>> getUserProfile(String token) async {
    final url = Uri.parse('http://10.0.2.2:8080/user/profile/details');
    print('token is $token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include token in Authorization header
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Successfully fetching user profile: ${response.statusCode}');
      final body = jsonDecode(response.body);
      print('Successfully fetching user profile: ${body['message']}');
      Map<String, dynamic> usersMap = body["data"];

      print('User ID: ${usersMap['id']}');
      print('Name: ${usersMap['name']}');
      print('Email: ${usersMap['email']}');
      print('Phone: ${usersMap['phone']}');
      return usersMap; // Return user profile data as a map
    } else {
      print('Error fetching user profile: ${response.statusCode}');
      print(response.body); // Log the error response for debugging
      final data = jsonDecode(response.body);
      return data; // Indicate failure
    }
  }
}
