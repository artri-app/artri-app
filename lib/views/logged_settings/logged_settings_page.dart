import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/health_view_model.dart';
import 'package:flutter/material.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoggedSettingsPage extends StatefulWidget {
  const LoggedSettingsPage({super.key});

  @override
  State<LoggedSettingsPage> createState() => _LoggedSettingsPageState();
}

class _LoggedSettingsPageState extends State<LoggedSettingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HealthViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Configurações',
            style: TextStyle(fontSize: 32, color: Color(0xFF217A84)),
          ),
          const SizedBox(height: 48),
          CustomSolidButton(
            text: 'Alterar Email',
            onPressed: () => context.go(SettingsRoutes.changeEmail),
            gradientColors: AppGradients.greenGradient,
          ),
          const SizedBox(height: 16),
          CustomSolidButton(
            text: 'Alterar Senha',
            onPressed: () => context.go(SettingsRoutes.changePassword),
            gradientColors: AppGradients.greenGradient,
          ),
          const SizedBox(height: 16),
          Consumer<HealthViewModel>(
            builder: (context, vm, _) {
              if (vm.isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(),
                );
              }

              final buttonText = !vm.isAvailable
                  ? 'Instalar Health Connect'
                  : (vm.isConnected
                      ? 'Desconectar Smartwatch'
                      : 'Conectar Smartwatch / Health Connect');
              final VoidCallback? onPressed = !vm.isAvailable
                  ? () { vm.installHealthConnect(); }
                  : (vm.isConnected
                      ? () { vm.disconnectHealth(); }
                      : () { vm.connectHealth(); });

              return Column(
                children: [
                  CustomSolidButton(
                    text: buttonText,
                    onPressed: onPressed,
                    gradientColors: AppGradients.greenGradient,
                    fontSize: 22,
                  ),
                  if (vm.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        vm.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Consumer<HealthViewModel>(
            builder: (context, vm, _) {
              return CustomSolidButton(
                text: 'Simular Dados de Smartwatch',
                onPressed:
                    vm.isLoading ? null : () => vm.simulateData(),
                gradientColors: [Colors.grey.shade400, Colors.grey.shade600],
                fontSize: 18,
              );
            },
          ),
        ],
      ),
    );
  }
}
