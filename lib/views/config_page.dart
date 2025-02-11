import 'package:flutter/material.dart';
import 'package:artriapp/views/widgets/button.dart';
import 'package:artriapp/views/widgets/navbar.dart';
import 'package:artriapp/views/change_email_page.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  void _navigateToChangeEmailPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ChangeEmailPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            color: const Color(0xFF026873),
            onPressed: () {
              // Do something
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundColor: Color(0xFF025940),
              ),
              const SizedBox(height: 16),
              const Text(
                'Configurações',
                style: TextStyle(fontSize: 32, color: Color(0xFF217A84)),
              ),
              const SizedBox(height: 48),
              CustomButton(
                text: 'Alterar Email',
                onPressed: () => _navigateToChangeEmailPage(context),
                gradientColors: const [Color(0xFF03A64B), Color(0xFF04BF89)],
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Alterar Senha',
                onPressed: () {
                  // Do something
                },
                gradientColors: const [Color(0xFF03A64B), Color(0xFF04BF89)],
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Permissões',
                onPressed: () {
                  // Do something
                },
                gradientColors: const [Color(0xFF03A64B), Color(0xFF04BF89)],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
