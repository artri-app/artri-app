class GenericApiResponse {
  final String? message;
  final bool isSuccess;

  const GenericApiResponse({required this.message, required this.isSuccess});

  factory GenericApiResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'message': String msg,
      } =>
        GenericApiResponse(message: msg, isSuccess: true),
      {
        'error': String error,
      } =>
        GenericApiResponse(message: error, isSuccess: false),
      _ => throw const FormatException(
          'Invalid structure of Generic Api Response'),
    };
  }
}
