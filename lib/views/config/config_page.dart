import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:go_router/go_router.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
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
                  onPressed: () => context.go(Routes.changeEmail),
                  gradientColors: const [Color(0xFF03A64B), Color(0xFF04BF89)],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Alterar Senha',
                  onPressed: () => context.go(Routes.changePassword),
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
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.settings, color: AppColors.darkBlue),
            iconSize: 42,
          ),
        ),
      ],
    );
  }
}
