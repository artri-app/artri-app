import 'package:flutter/material.dart';
import 'package:artriapp/views/widgets/input_text.dart';
import 'package:artriapp/views/widgets/button.dart';
import 'package:artriapp/views/widgets/navbar.dart';

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

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
                'Alterar E-mail',
                style: TextStyle(fontSize: 32, color: Color(0xFF217A84)),
              ),
              const SizedBox(height: 48),
              const Text(
                'Insira seu novo e-mail de acesso',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const InputText(placeholder: 'E-mail'),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Enviar',
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
