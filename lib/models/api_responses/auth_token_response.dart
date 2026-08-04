class AuthTokenResponse {
  final String accessToken;
  final String refreshToken;

  const AuthTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) {
    // A rota de refresh devolve apenas o token de acesso.
    return AuthTokenResponse(
      accessToken: json['access'] as String? ?? '',
      refreshToken: json['refresh'] as String? ?? '',
    );
  }
}
