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
          label: 'Exercício',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Evolução',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: 'Diário',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Artrite',
        ),
      ],
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.greenAccent[600],
      backgroundColor: Colors.greenAccent[100],
      iconSize: 32,
    );
  }
}
