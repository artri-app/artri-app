import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.75,
            child: Expanded(
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Alterar senha'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 36,
                            color: const Color(0xff026873),
                          ),
                        ),
                        const Gap(16),
                        const InputText(
                          placeholder: '*******',
                          label: 'Insira a sua senha antiga:',
                        ),
                        const Gap(16),
                        const InputText(
                          placeholder: '*******',
                          label: 'Insira a sua nova senha:',
                        ),
                        
                      ],
                    ),
                    const Gap(40),
                    CustomSolidButton(
                      text: 'Enviar',
                      onPressed: () {
                        // Do something
                      },
                      fontSize: 32,
                      gradientColors: AppGradients.greenGradient,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
