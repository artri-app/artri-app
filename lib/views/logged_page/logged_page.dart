import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoggedPage extends StatefulWidget {
  const LoggedPage({super.key});

  @override
  State<LoggedPage> createState() => _LoggedPageState();
}

class _LoggedPageState extends State<LoggedPage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 48.0,
            ),
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                HomePage(),
                ExercisePage(),
                InfoPage(),
                Center(
                  child: Text(
                    'Evolution Page',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () => context.goNamed(
                Routes.configuration,
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
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
