import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/info/widget/info_template_page.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/bullet_list.dart';
import 'package:artriapp/views/widgets/hint_indicator_tooltip.dart';

class LeisDireitosInfoPage extends StatelessWidget {
  const LeisDireitosInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoTemplatePage(
      title: 'Leis e Direitos',
      videoUrl: 'https://youtu.be/mYzst-M6O24',

      sections: [
        const SessionTitle(title: 'Seus direitos'),
        const Gap(12),

        const Text(
          'Além do tratamento médico, existem diversos direitos garantidos por lei que ajudam no dia a dia com mais dignidade e segurança.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(16),

        const BulletList(
          items: [
            'Benefícios do INSS',
            'Medicamentos gratuitos pelo SUS',
            'Reconhecimento como PCD',
            'Direitos de mobilidade e trabalho',
          ],
        ),

        const Gap(24),

        const SessionTitle(title: '1. Benefício por incapacidade (INSS)'),
        const Gap(12),

        const Text(
          'Em casos mais severos, a artrite reumatoide pode impedir o trabalho.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const Text(
          'Auxílio-doença (temporário): quando há incapacidade temporária.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Text(
          'Aposentadoria por invalidez: quando a incapacidade é permanente.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const SessionTitle(title: 'Requisitos'),
        const Gap(12),

        const BulletList(
          items: [
            'Estar contribuindo ou no período de graça',
            'Passar por perícia médica',
            'Apresentar laudo médico',
            'Ter pelo menos 12 contribuições (em geral)',
          ],
        ),

        const Gap(24),

        const SessionTitle(title: '2. Medicamentos pelo SUS'),
        const Gap(12),

        const Text(
          'O SUS garante acesso gratuito a medicamentos, inclusive de alto custo.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const BulletList(
          items: [
            'Laudo médico recomendando o tratamento',
            'Ausência de alternativa eficaz no SUS',
            'Comprovação de necessidade',
          ],
        ),

        const Gap(12),

        Row(
          children: const [
            Expanded(
              child: Text(
                'A saúde é um direito garantido pela Constituição.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            HintIndicatorTooltip(
              tooltipMessage: 'Direito universal e dever do Estado.',
            ),
          ],
        ),

        const Gap(24),

        const SessionTitle(title: '3. BPC / LOAS'),
        const Gap(12),

        const Text(
          'Benefício para pessoas com deficiência ou idosos em situação de vulnerabilidade.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const BulletList(
          items: [
            'Renda familiar baixa',
            'Avaliação do INSS',
            'Laudo médico atualizado',
          ],
        ),

        const Gap(12),

        const Text(
          'Valor: 1 salário mínimo mensal (sem necessidade de contribuição).',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: '4. Pessoa com Deficiência (PCD)'),
        const Gap(12),

        const Text(
          'Casos mais graves podem garantir reconhecimento como PCD.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const SessionTitle(title: 'Direitos garantidos'),
        const Gap(12),

        const BulletList(
          items: [
            'Atendimento prioritário',
            'Vagas especiais',
            'Cotas em concursos',
            'Adaptação no trabalho',
            'Isenção de impostos',
          ],
        ),

        const Gap(12),

        const Text(
          'Esse reconhecimento depende de avaliação biopsicossocial.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: 'Importante'),
        const Gap(12),

        Row(
          children: const [
            Expanded(
              child: Text(
                'Cada caso deve ser analisado individualmente.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Procure um advogado ou a Defensoria Pública.',
            ),
          ],
        ),

        const Gap(16),

        const Text(
          'Este conteúdo é informativo e não garante automaticamente os direitos.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ],
    );
  }
}