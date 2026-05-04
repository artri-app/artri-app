import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/info/widget/info_template_page.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/hint_indicator_tooltip.dart';
import 'package:artriapp/views/widgets/bullet_list.dart';
import 'package:artriapp/views/widgets/reference_link_text.dart';

class EmocionalInfoPage extends StatelessWidget {
  const EmocionalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoTemplatePage(
      title: 'Emocional',
      videoUrl: 'https://www.youtube.com/watch?v=zibqac4J9t8',

      sections: [
        const SessionTitle(title: 'Saúde emocional'),
        const Gap(12),

        const Text(
          'Depressão e ansiedade são condições frequentes em pessoas com artrite reumatoide. '
          'As dores, limitações e mudanças na rotina podem impactar diretamente a qualidade de vida e o estado emocional.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(16),

        Row(
          children: const [
            Text(
              'Ansiedade e depressão',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 6),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Condições de saúde mental que afetam humor, pensamentos e comportamento.',
            ),
          ],
        ),

        const Gap(24),

        const SessionTitle(title: 'Sinais de alerta'),
        const Gap(12),

        const Text(
          'Fique atento aos seguintes sintomas:',
          style: TextStyle(fontSize: 16),
        ),

        const Gap(12),

        const BulletList(
          items: [
            'Tristeza persistente',
            'Cansaço excessivo',
            'Perda de interesse em atividades prazerosas',
            'Irritabilidade',
            'Alterações no sono ou apetite',
            'Dificuldade de concentração',
            'Preocupação ou medo constante',
          ],
        ),

        const Gap(24),

        const SessionTitle(title: 'Quando buscar ajuda'),
        const Gap(12),

        const Text(
          'Se você se identificar com esses sintomas, procure ajuda de profissionais de saúde mental, como psicólogos e psiquiatras.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: 'Acesso pelo SUS'),
        const Gap(12),

        const Text(
          'Você pode ter acesso a atendimento psicológico pelo SUS indo até a UBS mais próxima com seus documentos.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const Text(
          'O atendimento pode ocorrer na própria unidade ou por encaminhamento para um CAPS (Centro de Atenção Psicossocial).',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const Text(
          'Também é possível acompanhar informações pelo aplicativo Conecte SUS.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        const SessionTitle(title: 'Referências'),
        const Gap(12),

        const ReferenceLinkText(
          text: 'MELLA, L. F.; BÉRTOLO, M. B.; DALGALARRONDO, P. Depressive symptoms in rheumatoid arthritis, (2010).',
          url: 'https://doi.org/10.1590/S1516-44462010005000021',
        ),
      ],
    );
  }
}