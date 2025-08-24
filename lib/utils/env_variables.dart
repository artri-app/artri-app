import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String apiUrl =
      dotenv.env['API_URL'] ?? "http://200.136.215.174/api";
}
