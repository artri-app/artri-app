import 'package:artriapp/views/widgets/button.dart';
import 'package:artriapp/views/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artriapp/views/home/home_page.dart';
import 'package:artriapp/views/login/send_password.dart';

class Login extends StatefulWidget {
  const Login({super.key, this.title = 'ArtriApp'});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const CircleAvatar(
              radius: 64,
              backgroundColor: Color(0xFF025940),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: const Column(
                children: [
                  InputText(placeholder: 'Usuário'),
                  SizedBox(height: 24),
                  InputText(placeholder: 'Senha')
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'ENTRAR',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              borderRadius: 20,
              gradientColors: const [
                Color.fromARGB(255, 3, 166, 74),
                Color.fromARGB(255, 4, 191, 138),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SendPassword()),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              child: const Text(
                'ESQUECI MINHA SENHA',
                style: TextStyle(
                    color: Color.fromARGB(255, 4, 191, 138),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
            const Text(
              'Caso não possua conta, cadastre-se!',
              style: TextStyle(
                  color: Color.fromARGB(255, 3, 166, 74),
                  fontSize: 22,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'CADASTRAR',
              onPressed: () {},
              borderRadius: 20,
              gradientColors: const [
                Color.fromARGB(255, 2, 104, 115),
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
