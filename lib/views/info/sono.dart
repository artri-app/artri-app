import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/info/widget/info_template_page.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/bullet_list.dart';
import 'package:artriapp/views/widgets/reference_link_text.dart';

class SonoInfoPage extends StatelessWidget {
  const SonoInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoTemplatePage(
      title: 'Sono',
      videoUrl: 'https://youtu.be/S6eNJraEbF8',
      sections: [
        const SessionTitle(title: 'Sono e artrite reumatoide'),
        const Gap(12),
        const Text(
          'A dor crônica pode dificultar o sono, tornando mais difícil adormecer e permanecer dormindo.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const Gap(12),
        const Text(
          'Estudos mostram que cerca de 92% dos pacientes com artrite reumatoide relatam distúrbios do sono.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const Gap(24),
        const SessionTitle(title: 'Por que dormir bem é importante?'),
        const Gap(12),
        const Text(
          'Dormir bem ajuda a recuperar o corpo, controlar a dor e manter a saúde emocional.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const Gap(12),
        const Text(
          'Um sono de qualidade pode reduzir sintomas e melhorar a eficácia do tratamento.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const Gap(24),
        const SessionTitle(title: 'Como melhorar o sono'),
        const Gap(12),
        const BulletList(
          items: [
            'Manter horário regular para dormir',
            'Evitar telas antes de deitar',
            'Criar ambiente escuro e silencioso',
          ],
        ),
        const Gap(12),
        const Text(
          'Esses hábitos são conhecidos como higiene do sono.',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        const Gap(24),
        const SessionTitle(title: 'Dicas extras'),
        const Gap(12),
        const Text(
          'Relaxamento guiado e meditação podem ajudar a desacelerar a mente e o corpo.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const Gap(12),
        const Text(
          'Você pode acessar conteúdos de relaxamento dentro do próprio app.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const Gap(24),
        const SessionTitle(title: 'Referências'),
        const Gap(12),
        Text(
          'POLAK, Dagna; KORKOSZ, Mariusz; GUŁA, Zofia. Sleep disorders in rheumatoid arthritis, axial spondyloarthritis and psoriatic arthritis, (2025).',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
      ],
    );
  }
}
