import 'package:flutter/material.dart';
import 'package:artriapp/views/home/home_page.dart';
import 'package:artriapp/views/exercise/exercise_page.dart';
import 'package:artriapp/views/info/info_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, this.previousPage, this.currentPage});

  final int? previousPage;
  final int? currentPage;

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExercisePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InfoPage()),
        );
        break;
      case 3:
        print('Evolução tapped');
        break;
    }
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
      selectedItemColor: Colors.greenAccent[600],
      backgroundColor: Colors.greenAccent[100],
      iconSize: 32,
      onTap: _onItemTapped,
    );
  }
}
