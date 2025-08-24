class GenericApiResponse {
  final String message;

  const GenericApiResponse({required this.message});

  factory GenericApiResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'message': String msg,
      } =>
        GenericApiResponse(message: msg),
      _ => throw const FormatException(
          'Invalid structure of Generic Api Response'),
    };
  }
}
