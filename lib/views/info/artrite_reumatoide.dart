import 'package:artriapp/views/widgets/reference_link_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/info/widget/info_template_page.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/hint_indicator_tooltip.dart';
import 'package:artriapp/views/widgets/bullet_list.dart';

class ArtriteInfoPage extends StatelessWidget {
  const ArtriteInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoTemplatePage(
      title: 'Artrite Reumatoide',
      videoUrl: 'https://www.youtube.com/watch?v=DFurZ2KoRJ4',
      sections: [
        // ================= O QUE É =================
        const SessionTitle(title: 'O que é a doença'),
        const Gap(12),

        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            Text(
              'Você já ouviu falar em artrite reumatoide? Essa é uma doença ',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            Text(
              'crônica',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(' e ', style: TextStyle(fontSize: 16)),
            Text(
              'autoimune,',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Doença em que o sistema imunológico ataca o próprio corpo.',
            ),
            Text(
              ' o que significa que o próprio sistema imunológico passa a atacar as articulações do corpo. '
              'Isso causa dor, inchaço e rigidez principalmente nas mãos, punhos, joelhos e pés.\n',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),

        const Gap(12),

        const Text(
          'Ela afeta cerca de 0,5% a 1% da população adulta e pode durar anos ou até por toda a vida.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        // ================= CAUSAS =================
        const SessionTitle(title: 'O que causa?'),
        const Gap(12),

        const Text(
          'Por mais que não seja totalmente entendido por que uma pessoa desenvolve artrite reumatoide, '
          'pesquisas identificam alguns fatores de risco. Fatores genéticos aumentam a predisposição, '
          'assim como fatores ambientais, como tabagismo e excesso de peso. Gatilhos como estresse, trauma '
          'ou doenças também podem influenciar.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        // ================= SINTOMAS =================
        const SessionTitle(title: 'Sintomas'),
        const Gap(12),

        const Text(
          'Os sintomas mais comuns são rigidez, inchaço, dor e fadiga.',
          style: TextStyle(fontSize: 16),
        ),

        const Gap(12),

        Row(
          children: const [
            Text(
              'Fadiga',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 6),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Cansaço intenso que não melhora apenas com descanso.',
            ),
          ],
        ),

        const Gap(8),

        const Text(
          'A fadiga vai além do cansaço comum e pode afetar tarefas do dia a dia, vida social, trabalho e qualidade de vida.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        // ================= ALERTAS =================
        const SessionTitle(title: 'Como reconhecer sintomas preocupantes'),
        const Gap(12),

        const BulletList(
          items: [
            'Dor articular muito intensa e persistente',
            'Inchaços que não reduzem com o repouso',
            'Vermelhidão ou calor excessivo',
            'Tontura ou dor no peito durante o exercício',
            'Ferimentos nos pés após a atividade',
          ],
        ),

        const Gap(16),

        const Text(
          'Em caso de dúvidas, procure a Unidade Básica de Saúde mais próxima.',
          style: TextStyle(fontSize: 16),
        ),

        const Gap(24),

        // ================= DIAGNÓSTICO =================
        const SessionTitle(title: 'Diagnóstico'),
        const Gap(12),

        const Text(
          'Segundo o Colégio Americano de Reumatologia, o diagnóstico envolve avaliação médica, exames de sangue e exames de imagem como raio-X, ressonância magnética ou ultrassom.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        // ================= PROGRESSÃO =================
        const SessionTitle(title: 'Progressão da doença'),
        const Gap(12),

        const Text(
          'A artrite reumatoide não tem a mesma evolução para todo mundo. '
          'Em algumas pessoas, os sintomas aparecem de forma leve e permanecem estáveis. '
          'Em outras, pode haver progressão mais intensa com inflamação persistente.\n\n'
          'O acompanhamento médico regular é essencial para manter a qualidade de vida.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        // ================= REFERÊNCIAS =================
        const SessionTitle(title: 'Referências'),
        const Gap(12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Smolen JS, Aletaha D, McInnes IB. Rheumatoid arthritis. The Lancet. 2016.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            Text(
              'Lorig KR, Holman HR. Self-Management Education. Ann Behav Med. 2003.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            Text(
              'Conforti A et al. Extra-articular manifestations in rheumatoid arthritis. Autoimmun Rev. 2021.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            Text(
              'Scott DL et al. Early rheumatoid arthritis consequences. Best Pract Res Clin Rheumatol. 2005.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            Text(
              'Kitas GD et al. Cardiovascular disease in RA. Ann Rheum Dis. 2011.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            Text(
              'Zangi HA et al. Patient education recommendations. Ann Rheum Dis. 2015.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            Text(
              'Nikiphorou E et al. Self-management strategies. Ann Rheum Dis. 2021.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            ReferenceLinkText(
              text:
                  'Rausch Osthoff AK et al. (2018) – Physical activity recommendations',
              url:
                  'https://ard.bmj.com/lookup/doi/10.1136/annrheumdis-2018-213585',
            ),

            Gap(8),

            ReferenceLinkText(
              text:
                  'DURES E et al. (2023) – Fatigue management recommendations',
              url: 'https://doi.org/10.1136/ard-2023-224514',
            ),
          ],
        ),
      ],
    );
  }
}
