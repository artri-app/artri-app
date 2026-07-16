import 'package:artriapp/utils/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityTokenService {
  static final SecurityTokenService _instance = SecurityTokenService._();

  factory SecurityTokenService() => _instance;

  SecurityTokenService._();

  final _securityStorage = const FlutterSecureStorage();
  String _accessToken = '';
  String _refreshToken = '';

  Future<void> init() async {
    _accessToken = (await _securityStorage.read(key: SecurityToken.accessToken.name)) ?? '';
    _refreshToken = (await _securityStorage.read(key: SecurityToken.refreshToken.name)) ?? '';
  }

  Future<void> saveToken(String token, SecurityToken key) async {
    await _securityStorage.write(key: key.name, value: token);
  }

  Future<String?> getToken(SecurityToken key) async {
    return await _securityStorage.read(key: key.name);
  }

  Future<void> deleteToken(SecurityToken key) async {
    await _securityStorage.delete(key: key.name);
  }

  Future<void> deleteAllTokens() async {
    await _securityStorage.deleteAll();
  }

  bool userLoggedIn() {
    return _accessToken.isNotEmpty && _refreshToken.isNotEmpty;
  }
}
