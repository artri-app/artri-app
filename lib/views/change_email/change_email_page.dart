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
        child: FractionallySizedBox(
          widthFactor: 0.75,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'ALTERAR E-MAIL',
                      style: TextStyle(fontSize: 32, color: Color(0xFF217A84)),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Insira seu novo e-mail de acesso:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    const InputText(placeholder: 'E-mail'),
                  ],
                ),
                CustomSolidButton(
                  text: 'Enviar',
                  onPressed: () {
                    // Do something
                  },
                  fontSize: 32,
                  gradientColors: AppGradients.greenGradient,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
