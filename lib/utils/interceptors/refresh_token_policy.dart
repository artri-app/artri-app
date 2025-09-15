import 'dart:async';

import 'package:artriapp/services/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:http_interceptor/http_interceptor.dart';

class RefreshTokenPolicy implements RetryPolicy {
  final AuthService _authService;
  final SecurityTokenService _securityTokenService;

  RefreshTokenPolicy(this._authService, this._securityTokenService);

  @override
  Duration delayRetryAttemptOnException({required int retryAttempt}) {
    return Duration.zero;
  }

  @override
  Duration delayRetryAttemptOnResponse({required int retryAttempt}) {
    return Duration.zero;
  }

  @override
  int get maxRetryAttempts => 1;

  @override
  FutureOr<bool> shouldAttemptRetryOnException(
      Exception reason, BaseRequest request) {
    return false;
  }

  @override
  FutureOr<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401) {
      var refreshToken =
          await _securityTokenService.getToken(SecurityToken.refreshToken);

      if (refreshToken == null) return false;

      var response = await _authService.refreshAuthToken(refreshToken);

      await _securityTokenService.saveToken(
          response.accessToken, SecurityToken.accessToken);
      await _securityTokenService.saveToken(
          response.refreshToken, SecurityToken.refreshToken);

      return true;
    }
    return false;
  }
}
