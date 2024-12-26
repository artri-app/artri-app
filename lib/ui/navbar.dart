import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Exercise',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Evolution',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: 'Diary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Artrite',
        ),
      ],
      currentIndex: 0,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.greenAccent[600],
      backgroundColor: Colors.greenAccent[100],
      onTap: (index) {
        // Handle item tap
      },
    );
  }
}
