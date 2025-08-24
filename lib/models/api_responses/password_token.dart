class PasswordToken {
  final String password;
  final String token;

  PasswordToken({
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'token': token,
    };
  }

  factory PasswordToken.fromMap(Map<String, dynamic> map) {
    return PasswordToken(
      password: map['password'],
      token: map['token'],
    );
  }
}
