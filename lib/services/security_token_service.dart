import 'package:artriapp/utils/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityTokenService {
  final _securityStorage = const FlutterSecureStorage();
  String _accessToken = '';
  String _refreshToken = '';

  SecurityTokenService() {
    _initTokens();
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

  Future<void> _initTokens() async {
    _accessToken = (await getToken(SecurityToken.accessToken)) ?? '';
    _refreshToken = (await getToken(SecurityToken.refreshToken)) ?? '';
  }
}
