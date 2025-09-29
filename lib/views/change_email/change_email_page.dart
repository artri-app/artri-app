import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

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
              gradientColors: AppGradients.greenGradient,
            ),
          ],
        ),
      ),
    );
  }
}
