import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LevelSelectorDialog extends StatelessWidget {
  const LevelSelectorDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var videoController = YoutubePlayerController(
      initialVideoId: 'apuX_N3jpw0',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
        disableDragSeek: true,
      ),
    );

    return Dialog(
      insetPadding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        128,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        spacing: 4,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 102,
                            color: Colors.indigo,
                          ),
                          Text(
                            'Como escolher o nível de exercício?',
                            style: GoogleFonts.montserrat(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreen,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    YoutubePlayer(controller: videoController),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Para garantir segurança e melhores resultados, recomendamos que todos iniciem pelo',
                          ),
                          TextSpan(
                            text: ' nível iniciante ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'mesmo que já tenham alguma experiência com exercícios.\nEsse é um bom ponto de partida para conhecer os movimentos, respeitar o seu corpo e evoluir com mais confiança.',
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text:
                            'Se, com o tempo, você perceber que os exercícios estão fáceis demais ou pouco desafiadores, você pode passar para o nível intermediário e, posteriormente, ao avançado de acordo com o seu progresso.',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Além disso, é importante ajustar o',
                          ),
                          TextSpan(
                            text: ' peso/carga dos exercícios',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                '. Sempre que sentir que está conseguindo realizar todas as repetições de forma confortável, sem esforço significativo, aumente aos poucos o peso utilizado.',
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Importante: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Caso algum exercício não possa ser realizado por você por qualquer motivo (dor, limitação física, insegurança ou outra particularidade), fique à vontade para pular. O mais importante é respeitar seus limites e seguir no seu ritmo.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
