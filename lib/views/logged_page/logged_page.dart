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

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 48.0,
              ),
              child: Center(
                child: child,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () => context.push(
                AppRoutes.configuration,
              ),
              icon: const Icon(
                Icons.settings_outlined,
                color: AppColors.darkGreen,
              ),
              iconSize: 42,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        onItemTapped: (idx) => _onItemTapped(context, idx),
        selectedIndex: _currentIndex(location.toString()),
      ),
    );
  }
}
