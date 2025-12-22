import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const NavBar({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });

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
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.white,
      selectedItemColor: AppColors.lightGreen,
      backgroundColor: AppColors.darkGreen,
      iconSize: 32,
      onTap: (value) => {onItemTapped.call(value)},
    );
  }
}
