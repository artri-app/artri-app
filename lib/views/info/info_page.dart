import 'package:artriapp/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () => context.push(InfoRoutes.artriteInfoPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            onPressed: () => context.push(InfoRoutes.treatmentsInfoPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            onPressed: () => context.push(InfoRoutes.myPainInfoPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            onPressed: () => context.push(InfoRoutes.sleepInfoPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            onPressed: () => context.push(InfoRoutes.foodRoutineInfoPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            onPressed: () => context.push(InfoRoutes.emotionalPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Emocional',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const Gap(16),
          ElevatedButton(
            onPressed: () => context.push(InfoRoutes.exercisesInfoPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Exercício físico',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const Gap(16),
          ElevatedButton(
            onPressed: () => context.push(InfoRoutes.lawsInfoPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          const Gap(16),
          ElevatedButton(
            onPressed: () => context.push(InfoRoutes.mythsTruthsInfoPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Mitos e Verdades',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
