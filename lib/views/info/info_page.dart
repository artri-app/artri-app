import 'package:artriapp/routes/app.routes.dart';
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
            onPressed: () => context.push(AppRoutes.artriteInfoPage),
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
            onPressed: () => context.push(AppRoutes.treatmentsInfoPage),
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
            onPressed: () => context.push(AppRoutes.myPainInfoPage),
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
            onPressed: () => context.push(AppRoutes.sleepInfoPage),
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
            onPressed: () => context.push(AppRoutes.foodRoutineInfoPage),
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
            onPressed: () => context.push(AppRoutes.lawsInfoPage),
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
        ],
      ),
    );
  }
}
