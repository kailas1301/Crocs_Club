// Model for SignUp
class SignUpRequest {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, String> toJson() {
    return {
      'confirmpassword': confirmPassword,
      'email': email,
      'name': name,
      'password': password,
      'phone': phone,
    };
  }
}
