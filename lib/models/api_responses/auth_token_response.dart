class AuthTokenResponse {
  final String accessToken;
  final String refreshToken;

  const AuthTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) {
    return AuthTokenResponse(
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] as String,
    );
  }
}
