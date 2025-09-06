import 'package:artriapp/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artriapp/views/info/data/alimentacao.dart';
import 'package:artriapp/views/info/data/artrite_reumatoide.dart';
import 'package:artriapp/views/info/data/leis_direitos.dart';
import 'package:artriapp/views/info/data/minha_dor.dart';
import 'package:artriapp/views/info/data/sono.dart';
import 'package:artriapp/views/info/data/tratamentos.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff025940),
        title: const Text(
          'Informações',
        ),
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 36,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
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
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArtriteReumatoideInfoPage(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF03A64A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Artrite Reumatóide',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TratamentosInfoPage(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF03A64A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Tratamentos',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MinhaDorInfoPage(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF03A64A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Minha Dor',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SonoInfoPage(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF03A64A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Sono',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AlimentacaoInfoPage(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF03A64A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Alimentação',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeisDireitosInfoPage(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF03A64A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Leis e Direitos',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentPage: 2, previousPage: 0),
    );
  }
}
