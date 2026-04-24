import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterHelper {
  static Uri getUriFromContext(BuildContext context) {
    return GoRouterState.of(context).uri;
  }
}
