import 'package:artriapp/views/widgets/button.dart';
import 'package:artriapp/views/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendPassword extends StatefulWidget {
  const SendPassword({super.key, required this.title});

  final String title;

  @override
  State<SendPassword> createState() => _SendPasswordState();
}

class _SendPasswordState extends State<SendPassword> {
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
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.green,
                width: 2.0,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.green,
                size: 24,
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
