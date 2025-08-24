class UserRegistration {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final num weight;
  final num height;

  UserRegistration({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.weight,
    required this.height,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate.toIso8601String(),
      'weight': weight,
      'height': height,
    };
  }

  UserRegistration fromMap(Map<String, dynamic> map) {
    return UserRegistration(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      birthDate: DateTime.parse(map['birth_date']),
      weight: map['weight'],
      height: map['height'],
    );
  }
}
