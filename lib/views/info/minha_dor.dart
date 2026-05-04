import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/widgets/video_player.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/bullet_list.dart';
import 'package:artriapp/views/widgets/reference_link_text.dart';
 
class MinhaDorInfoPage extends StatelessWidget { 
  const MinhaDorInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dor'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VideoPlayerWidget(
                videoUrl: 'https://youtu.be/n_Kmf6oUlHE',
              ),

              const Gap(24),

              const SessionTitle(title: 'O que é a dor?'),

              const Gap(12),

              const Text(
                'A dor funciona como um sistema de alarme do nosso corpo, indicando quando algo pode estar em perigo.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(12),

              const Text(
                'Ela é um mecanismo de proteção essencial — como quando você encosta em algo quente ou pisa em algo pontiagudo.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(24),

              const SessionTitle(title: 'Como esse sistema funciona?'),

              const Gap(12),

              const Text(
                'O cérebro é o centro de comando. Sensores espalhados pelo corpo enviam sinais que são interpretados por ele.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(12),

              const BulletList(
                items: [
                  'Sensores térmicos (temperatura)',
                  'Sensores mecânicos (pressão, impacto)',
                  'Sensores químicos (inflamação)',
                ],
              ),

              const Gap(24),

              const SessionTitle(title: 'Como o cérebro interpreta a dor'),

              const Gap(12),

              const Text(
                'O cérebro analisa as informações e decide se há perigo. Se sim, ele ativa o “alarme” da dor.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(12),

              const Text(
                'A intensidade da dor nem sempre reflete a gravidade do problema.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Gap(24),

              const SessionTitle(title: 'Sistema de alarme desregulado'),

              const Gap(12),

              const Text(
                'Em algumas pessoas, esse sistema pode ficar sensível demais, disparando mesmo sem perigo real.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(12),

              const Text(
                'Como um alarme que toca mesmo quando não há invasão.',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),

              const Gap(24),

              const SessionTitle(title: 'O que influencia a dor?'),

              const Gap(12),

              const BulletList(
                items: [
                  'Emoções (ansiedade, estresse)',
                  'Preocupações e pensamentos',
                  'Ambiente e contexto',
                  'Relações pessoais',
                ],
              ),

              const Gap(24),

              const SessionTitle(title: 'O que ajuda a regular a dor?'),

              const Gap(12),

              const Text(
                'O próprio cérebro produz substâncias que ajudam a controlar a dor.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(12),

              const BulletList(
                items: [
                  'Exercícios físicos',
                  'Exercícios de respiração e relaxamento',
                  'Entender melhor a dor',
                  'Retomar atividades gradualmente',
                ],
              ),

              const Gap(12),

              const Text(
                'Já fatores como estresse, medo e sedentarismo podem piorar o sistema de alarme.',
                style: TextStyle(fontSize: 16),
              ),

              const Gap(24),

              const SessionTitle(title: 'Dor na artrite reumatoide'),

              const Gap(12),

              const Text(
                'Na artrite reumatoide, o sistema imunológico ataca as articulações, causando inflamação e dor.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(12),

              const Text(
                'Com o tempo, o sistema pode ficar mais sensível, aumentando a frequência e intensidade da dor.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(24),

              const SessionTitle(title: 'Seu cérebro pode ajudar'),

              const Gap(12),

              const Text(
                'O cérebro produz substâncias naturais que ajudam a aliviar a dor — como uma “farmácia interna”.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const Gap(12),

              const BulletList(
                items: [
                  'Atividade física',
                  'Relaxamento e meditação',
                  'Metas graduais',
                  'Educação sobre a dor',
                ],
              ),

              const Gap(24),

              const SessionTitle(title: 'Importante'),

              const Gap(12),

              const Text(
                'Entender a dor ajuda o cérebro a se sentir mais seguro e reduzir o alarme.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Gap(24),

              const SessionTitle(title: 'Referências'),

              const Gap(12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('BUTLER, David S.; MOSELEY, G. Lorimer. Explicando a dor. Noigroup Publications, 2009.'),
                  ReferenceLinkText(
                    text: 'Pesquisa em Dor (2016)',
                    url: 'https://pesquisaemdor.com.br/?page_id=118',
                  ),
                ],
              ),

              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}