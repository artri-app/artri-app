import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.greenAccent[600],
      backgroundColor: Colors.greenAccent[100],
      iconSize: 32,
      onTap: _onItemTapped,
    );
  }
}
