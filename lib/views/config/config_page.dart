import 'package:artriapp/routes/index.dart';
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
                  onPressed: () => context.push(SettingsRoutes.changeEmail),
                  gradientColors: AppGradients.greenGradient,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Alterar Senha',
                  onPressed: () => context.push(SettingsRoutes.changePassword),
                  gradientColors: AppGradients.greenGradient,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Permissões',
                  onPressed: () {
                    // Do something
                  },
                  gradientColors: AppGradients.greenGradient,
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
