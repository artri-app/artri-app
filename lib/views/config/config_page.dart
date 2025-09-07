import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:artriapp/views/change_email/change_email_page.dart';
import 'package:artriapp/views/change_password/change_password.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 64,
              backgroundColor: AppColors.darkGreen,
            ),
            const SizedBox(height: 16),
            const Text(
              'Configurações',
              style: TextStyle(fontSize: 32, color: Color(0xFF217A84)),
            ),
            const SizedBox(height: 48),
            CustomButton(
              text: 'Alterar Email',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangeEmailPage(),
                ),
              ),
              gradientColors: const [Color(0xFF03A64B), Color(0xFF04BF89)],
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Alterar Senha',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordPage(),
                ),
              ),
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
    );
  }
}
