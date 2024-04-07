class UserProfile {
  final String email;
  final String name;
  final String phone;

  UserProfile({
    required this.email,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
    };
  }
}

class ChangePasswordPayload {
  final String oldPassword;
  final String newPassword;
  final String resettedPassword;

  ChangePasswordPayload({
    required this.oldPassword,
    required this.newPassword,
    required this.resettedPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'password': newPassword,
      'resetted_password': resettedPassword,
    };
  }
}
