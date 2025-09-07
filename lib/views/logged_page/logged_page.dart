import 'package:artriapp/views/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';

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
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomePage(),
            ExercisePage(),
            InfoPage(),
            Center(child: Text('Evolution Page')),
          ],
        ),
        bottomNavigationBar: NavBar(
          onItemTapped: _onItemTapped,
        ));
  }
}
