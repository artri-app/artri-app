import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/widgets/session_title.dart';

class MitosVerdadesInfoPage extends StatelessWidget {
  const MitosVerdadesInfoPage({super.key});

  Widget buildCard({
    required String title,
    required String description,
    required bool isMyth,
  }) {
    final color = isMyth ? Colors.red : Colors.green;
    final label = isMyth ? 'Mito' : 'Verdade';
    final icon = isMyth ? Icons.close : Icons.check;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Gap(8),
          Text(
            description,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mitos e Verdades')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SessionTitle(title: 'Sobre a doença'),
            const Gap(16),

            buildCard(
              title: 'Não há tratamento para artrite reumatoide',
              description:
                  'Existem diversos tratamentos eficazes, incluindo medicamentos e mudanças no estilo de vida.',
              isMyth: true,
            ),

            buildCard(
              title: 'Afeta apenas pessoas mais velhas',
              description:
                  'Pode atingir pessoas de diferentes idades.',
              isMyth: true,
            ),

            buildCard(
              title: 'Afeta só os ossos',
              description:
                  'Pode afetar pulmões, coração e outros órgãos.',
              isMyth: true,
            ),

            buildCard(
              title: 'Alimentação influencia nos sintomas',
              description:
                  'Uma dieta equilibrada ajuda a reduzir inflamação.',
              isMyth: false,
            ),

            buildCard(
              title: 'Estresse piora a doença',
              description:
                  'Pode agravar crises inflamatórias.',
              isMyth: false,
            ),

            const Gap(24),

            const SessionTitle(title: 'Exercício físico'),
            const Gap(16),

            buildCard(
              title: 'Exercício ajuda na mobilidade',
              description:
                  'Melhora função articular e reduz rigidez.',
              isMyth: false,
            ),

            buildCard(
              title: 'Exercício piora a artrite',
              description:
                  'O sedentarismo é que piora os sintomas.',
              isMyth: true,
            ),

            buildCard(
              title: 'Exercício piora a dor',
              description:
                  'Pode ajudar a aliviar a dor quando bem orientado.',
              isMyth: true,
            ),

            const Gap(24),

            const SessionTitle(title: 'Dor'),
            const Gap(16),

            buildCard(
              title: 'A dor é igual para todos',
              description:
                  'Varia entre pessoas e ao longo do tempo.',
              isMyth: true,
            ),

            const Gap(24),

            const SessionTitle(title: 'Relaxamento'),
            const Gap(16),

            buildCard(
              title: 'Relaxamento ajuda na dor',
              description:
                  'Reduz estresse e melhora o controle da dor.',
              isMyth: false,
            ),

            buildCard(
              title: 'Relaxamento não funciona',
              description:
                  'Ajuda a regular o sistema nervoso e melhorar o sono.',
              isMyth: true,
            ),

            const Gap(32),
          ],
        ),
      ),
    );
  }
}