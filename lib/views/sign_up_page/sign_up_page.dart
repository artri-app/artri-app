import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  final String title;

  const SignUpPage({super.key, required this.title});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(
              color: Color.fromARGB(255, 2, 89, 64),
              fontWeight: FontWeight.w300,
              fontSize: 50),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton.outlined(
            onPressed: () => Navigator.pop(context),
            iconSize: 24,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            style: IconButton.styleFrom(
              side: const BorderSide(
                color: Colors.green,
                width: 2,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Column(
                children: [
                  Text(
                    'Insira seu e-mail para receber sua senha de acesso',
                    style: GoogleFonts.jetBrainsMono(
                      textStyle: const TextStyle(
                        letterSpacing: 1.5,
                        color: Color.fromARGB(255, 115, 115, 115),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  const InputText(placeholder: 'E-MAIL')
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'ENVIAR',
              onPressed: () {},
              borderRadius: 40,
              gradientColors: const [
                Color.fromARGB(255, 3, 166, 74),
                Color.fromARGB(255, 4, 191, 138),
              ],
            ),
            const SizedBox(height: 80)
          ],
        ),
      ),
    );
  }
}
