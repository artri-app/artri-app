import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/info/widget/info_template_page.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/hint_indicator_tooltip.dart';
import 'package:artriapp/views/widgets/bullet_list.dart';
import 'package:artriapp/views/widgets/reference_link_text.dart';

class ExercicioInfoPage extends StatelessWidget {
  const ExercicioInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoTemplatePage(
      title: 'Exercício Físico',
      videoUrl: 'https://www.youtube.com/watch?v=eTdAmZOWyAg',

      sections: [
        const SessionTitle(title: 'Exercício físico'),
        const Gap(12),

        const Text(
          'Se você tem artrite reumatoide, saiba que se exercitar é altamente recomendado e seguro.\n\n'
          'A prática regular ajuda a proteger o coração, fortalecer os músculos e melhorar a dor, a funcionalidade e as atividades do dia a dia.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        Row(
          children: const [
            Text(
              'Atividades recomendadas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 6),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Exercícios leves a moderados adaptados à sua condição.',
            ),
          ],
        ),

        const Gap(12),

        const BulletList(
          items: [
            'Alongamentos',
            'Caminhadas',
            'Hidroginástica',
            'Musculação (com orientação)',
          ],
        ),

        const Gap(24),

        const SessionTitle(title: 'Cuidados antes de começar'),
        const Gap(12),

        const Text(
          'Toda prática deve ser adaptada à sua realidade. É importante fazer uma avaliação de saúde antes de iniciar.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const BulletList(
          items: [
            'Meça sua pressão (se tiver hipertensão)',
            'Avalie a glicemia (se tiver diabetes)',
            'Use roupas e calçados adequados',
          ],
        ),

        const Gap(24),

        const SessionTitle(title: 'Durante a atividade'),
        const Gap(12),

        const BulletList(
          items: [
            'Evite esforços excessivos',
            'Pare se sentir dor forte, tontura ou cansaço extremo',
            'Hidrate-se',
            'Use acessórios necessários (óculos, muletas, etc.)',
          ],
        ),

        const Gap(24),

        const SessionTitle(title: 'Após a atividade'),
        const Gap(12),

        const BulletList(
          items: [
            'Faça alongamentos leves',
            'Observe dores diferentes ou inchaços',
            'Procure a UBS se algo parecer fora do normal',
          ],
        ),

        const Gap(24),

        const SessionTitle(title: 'Importante'),
        const Gap(12),

        const Text(
          'Mesmo nos dias com mais dor, evite ficar totalmente parado. Movimentar-se com atividades leves ajuda a aliviar a rigidez e preservar a mobilidade.\n\n'
          'Respeite seus limites, mas mantenha o corpo ativo.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: 'Referências'),

        const Gap(12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ReferenceLinkText(
              text:
                  'Ye H. et al. (2022) – Effectiveness and safety of aerobic exercise for rheumatoid arthritis',
              url: 'https://doi.org/10.1186/s13102-022-00408-2',
            ),
            Gap(8),

            ReferenceLinkText(
              text:
                  'Rausch Osthoff AK et al. (2018) – EULAR recommendations for physical activity',
              url: 'https://doi.org/10.1136/annrheumdis-2018-213585',
            ),
          ],
        ),
      ],
    );
  }
}