import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoggedPage extends StatelessWidget {
  final Widget child;
  const LoggedPage({super.key, required this.child});

  int _currentIndex(String location) {
    switch (location) {
      case AppRoutes.diary:
        return 0;
      case AppRoutes.exercise:
        return 1;
      case AppRoutes.info:
        return 2;
      case AppRoutes.evolution:
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.diary);
        break;
      case 1:
        context.go(AppRoutes.exercise);
        break;
      case 2:
        context.go(AppRoutes.info);
        break;
      case 3:
        context.go(AppRoutes.evolution);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          primary: true,
          child: SizedBox(
            height: size.height - 66,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: child,
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        onItemTapped: (idx) => _onItemTapped(context, idx),
        selectedIndex: _currentIndex(location.toString()),
      ),
    );
  }
}
