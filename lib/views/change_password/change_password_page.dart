import 'package:artriapp/views/widgets/input_text.dart';
import 'package:artriapp/views/widgets/navbar.dart';
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () => {},
              iconSize: 40,
              icon: const Icon(
                Icons.settings,
                color: Color(0xff025940),
              ),
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xff025940),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 110,
                    ),
                  ),
                  const Gap(24),
                  Text(
                    'Alterar senha'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      color: const Color(0xff026873),
                    ),
                  ),
                  const Gap(42),
                  const InputText(
                    placeholder: '*******',
                    label: 'Insira a sua senha antiga:',
                  ),
                  const Gap(42),
                  const InputText(
                    placeholder: '*******',
                    label: 'Insira a sua nova senha:',
                  ),
                  const Gap(42),
                  ElevatedButton(
                      onPressed: () => {}, child: const Text('Enviar'))
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
