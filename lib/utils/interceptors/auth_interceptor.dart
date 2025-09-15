import 'dart:async';

import 'package:artriapp/services/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {
  final SecurityTokenService _securityTokenService;

  AuthInterceptor(this._securityTokenService);

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    var accessToken = _securityTokenService.getToken(SecurityToken.accessToken);

    request.headers["Authorization"] = "Bearer $accessToken";

    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return _securityTokenService.userLoggedIn();
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}
