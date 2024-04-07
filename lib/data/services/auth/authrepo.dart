import 'dart:convert';
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:crocs_club/domain/models/login_model.dart';
import 'package:crocs_club/domain/models/signup_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static const String _baseUrl = 'http://10.0.2.2:8080';
  static const String _signupEndpoint = '/user/signup';
  static const String _loginEndpoint = '/user/login';

  // Function to handle user signup
  Future<String> signup(SignUpRequest signupRequest) async {
    try {
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
    } catch (e) {
      print('Error during signup: $e');
      throw Exception('Signup failed: $e');
    }
  }

  // Function to handle user login
  Future<String> login(LoginRequest loginRequest) async {
    try {
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
        print('Login successful!');
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
        print(
            'Login failed $errorMessage with status code: ${response.statusCode}');
        return errorMessage;
      }
    } catch (e) {
      print('Error during login: $e');
      throw Exception('Login failed: $e');
    }
  }
}
