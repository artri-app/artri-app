import 'package:artriapp/views/widgets/reference_link_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/info/widget/info_template_page.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/hint_indicator_tooltip.dart';
import 'package:artriapp/views/widgets/bullet_list.dart';

class TratamentosInfoPage extends StatelessWidget {
  const TratamentosInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoTemplatePage(
      title: 'Tratamentos',
      videoUrl: 'https://www.youtube.com/watch?v=gtcebctX224',
      sections: [
        // ================= TIPOS DE TRATAMENTO =================
        const SessionTitle(title: 'Tipos de tratamento'),
        const Gap(12),

        const Text(
          'Para tratar a artrite reumatoide podem ser usadas medicações associadas a outras terapias, como fisioterapia, terapia ocupacional, acompanhamento nutricional e apoio psicológico.\n\n'
          'Tudo isso ajuda a controlar os sintomas e melhorar sua qualidade de vida.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(16),

        Row(
          children: const [
            Text(
              'Medicamentos Modificadores do Curso da Doença',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 6),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Medicamentos que controlam a progressão da doença e reduzem inflamações.',
            ),
          ],
        ),

        const Gap(24),

        // ================= SUS =================
        const SessionTitle(title: 'Acesso ao tratamento pelo SUS'),
        const Gap(12),

        const Text(
          'Para marcar uma consulta no SUS, você pode ir até a Unidade Básica de Saúde (UBS) mais próxima com seus documentos ou usar o aplicativo Conecte SUS.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const Text(
          'Se o tratamento com medicamentos for necessário, alguns remédios estão disponíveis no SUS, incluindo medicamentos sintéticos e biológicos.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const Text(
          'A automedicação não deve ser realizada. É necessário consultar um reumatologista, apresentar exames e documentos e seguir o processo de aprovação para retirada dos medicamentos.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        // ================= ACOMPANHAMENTO =================
        const SessionTitle(title: 'Importância do acompanhamento'),
        const Gap(12),

        const Text(
          'Seguir as orientações médicas e manter o acompanhamento é essencial para que o tratamento funcione corretamente e possíveis efeitos colaterais sejam identificados a tempo.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(24),

        // ================= ÓRTESES =================
        const SessionTitle(title: 'Uso de órteses'),
        const Gap(12),

        Row(
          children: const [
            Text(
              'Órteses',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 6),
            HintIndicatorTooltip(
              tooltipMessage:
                  'Dispositivos usados para apoiar, alinhar ou corrigir articulações.',
            ),
          ],
        ),

        const Gap(12),

        const Text(
          'O uso de órteses pode ser indicado para reduzir a dor, prevenir deformidades e auxiliar nas tarefas do dia a dia.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const BulletList(
          items: [
            'Órteses para punhos',
            'Órteses para dedos',
            'Órteses para tornozelo e pé',
          ],
        ),

        const Gap(12),

        const Text(
          'A escolha deve ser orientada por um fisioterapeuta ou terapeuta ocupacional.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),

        const Gap(12),

        const Text(
          'As órteses não substituem o tratamento medicamentoso nem os exercícios.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
              'Zangi HA et al. Patient education recommendations. Ann Rheum Dis. 2015.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            Text(
              'Nikiphorou E et al. Self-management strategies. Ann Rheum Dis. 2021.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            /// 🔗 LINK
            ReferenceLinkText(
              text:
                  'Rausch Osthoff AK et al. (2018) – Physical activity recommendations',
              url:
                  'https://ard.bmj.com/lookup/doi/10.1136/annrheumdis-2018-213585',
            ),

            Gap(8),

            Text(
              'England BR et al. Exercise and rehabilitation guidelines. Arthritis Care Res. 2023.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            Gap(8),

            Text(
              'Fraenkel L et al. Treatment guideline for rheumatoid arthritis. Arthritis Care Res. 2021.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ],
    );
  }
}
