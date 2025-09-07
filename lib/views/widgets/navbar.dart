import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.onItemTapped});

  final ValueChanged<int> onItemTapped;

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onItemTapped(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: 'Diário',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Exercício',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Informações',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Evolução',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.white,
      selectedItemColor: AppColors.lightGreen,
      backgroundColor: AppColors.darkGreen,
      iconSize: 32,
      onTap: _onItemTapped,
    );
  }
}
