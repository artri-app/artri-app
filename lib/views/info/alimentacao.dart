import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/info/widget/info_template_page.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/bullet_list.dart';
import 'package:artriapp/views/widgets/reference_link_text.dart';
import 'package:artriapp/views/widgets/hint_indicator_tooltip.dart';

class AlimentacaoInfoPage extends StatelessWidget {
  const AlimentacaoInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoTemplatePage(
      title: 'Alimentação',
      videoUrl: 'https://youtu.be/0YpBhy9LKQM',

      sections: [
        const SessionTitle(title: 'Alimentação e saúde'),
        const Gap(12),

        const Text(
          'A alimentação pode influenciar diretamente a sua saúde e bem-estar.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const Text(
          'Manter uma alimentação equilibrada ajuda na prevenção e no controle de diversas condições.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: 'Atenção com dietas prontas'),
        const Gap(12),

        Row(
          children: const [
            Expanded(
              child: Text(
                'Evite seguir dietas genéricas da internet ou recomendações de outras pessoas.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Cada pessoa tem necessidades nutricionais diferentes.',
            ),
          ],
        ),

        const Gap(12),

        const Text(
          'Procure um nutricionista para um plano alimentar individualizado.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: 'Hidratação'),
        const Gap(12),

        const Text(
          'Manter um consumo adequado de água é essencial para o bom funcionamento do organismo.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const Text(
          'A quantidade ideal varia conforme idade, peso, atividade física e condições de saúde.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: 'Hábitos de vida'),
        const Gap(12),

        const Text(
          'Alguns hábitos podem impactar diretamente a artrite reumatoide:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const BulletList(
          items: [
            'Tabagismo pode acelerar danos nas articulações',
            'Fumantes tendem a ter doença mais severa',
            'Álcool pode interagir com medicamentos',
          ],
        ),

        const Gap(12),

        const Text(
          'Medicamentos como metotrexato, paracetamol e anti-inflamatórios podem ter efeitos adversos quando combinados com álcool.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: 'Importante'),
        const Gap(12),

        Row(
          children: const [
            Expanded(
              child: Text(
                'O cuidado com a alimentação deve ser individualizado e feito com responsabilidade.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Sempre siga orientação de profissionais da saúde.',
            ),
          ],
        ),

        const Gap(24),

        const SessionTitle(title: 'Referências'),
        const Gap(12),

        const ReferenceLinkText(
          text: 'Philippou E, Petersson SD, Rodomar C, Nikiphorou E. Rheumatoid arthritis and dietary interventions: systematic review of clinical trials, (2021).',
          url: 'https://doi.org/10.1093/nutrit/nuaa033',
        ),

        const Gap(8),

        const ReferenceLinkText(
          text: 'Turk, J.N., Zahavi, E.R., Gorman, A.E. et al. Exploring the effect of alcohol on disease activity and outcomes in rheumatoid arthritis through systematic review and meta-analysis, 2021.',
          url: 'https://doi.org/10.1038/s41598-021-89618-1',
        ),

        const Gap(8),

        const ReferenceLinkText(
          text: 'SAHLSTRAND-JOHANSSON, E. et al. Smoking as a predictor of radiographic progression in early rheumatoid arthritis: a prospective observational study from the SWEFOT trial, (2013)',
          url: 'https://doi.org/10.1136/annrheumdis-2012-201484',
        ),
      ],
    );
  }
}