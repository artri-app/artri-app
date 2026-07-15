import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:go_router/go_router.dart';

class LoggedSettingsPage extends StatelessWidget {
  const LoggedSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text(
            'CONFIGURAÇÕES',
            style: TextStyle(fontSize: 40, color: Color(0xFF217A84)),
          ),
          const SizedBox(height: 48),
          CustomSolidButton(
            text: 'ALTERAR SENHA',
            onPressed: () => context.push(SettingsRoutes.changePassword),
            gradientColors: AppGradients.greenGradient,
          ),
          const SizedBox(height: 16),
          CustomSolidButton(
            text: 'ALTERAR EMAIL',
            onPressed: () => context.push(SettingsRoutes.changeEmail),
            gradientColors: AppGradients.greenGradient,
          ),
          const SizedBox(height: 16),
          CustomSolidButton(
            text: 'PERMISSÕES',
            onPressed: () {
              // Do something
            },
            gradientColors: AppGradients.greenGradient,
          ),
        ],
      ),
    );
  }
}
