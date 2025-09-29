import 'package:artriapp/utils/enums/input_text_type.dart';
import 'package:artriapp/utils/app_routes.dart';
import 'package:artriapp/view_models/login_view_model.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 2, 89, 64),
            fontWeight: FontWeight.w300,
            fontSize: 50,
          ),
        ),
      ),
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          final Size screenSize = MediaQuery.of(context).size;

          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * 0.8,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/logo-ArtriApp-v2.svg',
                        ),
                        InputText(
                          placeholder: 'Usuário',
                          value: viewModel.email,
                          onValueChanged: (value) => viewModel.setEmail(value),
                        ),
                        const SizedBox(height: 24),
                        InputText(
                          placeholder: 'Senha',
                          onValueChanged: (value) =>
                              viewModel.setPassword(value),
                          type: InputTextType.password,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'ENTRAR',
                    onPressed: () async {
                      await viewModel.handleUserLoginButton(context);
                    },
                    borderRadius: 20,
                    gradientColors: const [
                      Color.fromARGB(255, 3, 166, 74),
                      Color.fromARGB(255, 4, 191, 138),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      'ESQUECI MINHA SENHA',
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 191, 138),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Text(
                    'Caso não possua conta, cadastre-se!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 166, 74),
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'CADASTRAR',
                    onPressed: () {
                      context.go(AppRoutes.signUp);
                    },
                    borderRadius: 20,
                    gradientColors: const [
                      Color.fromARGB(255, 2, 104, 115),
                      Color.fromARGB(255, 4, 191, 138),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
