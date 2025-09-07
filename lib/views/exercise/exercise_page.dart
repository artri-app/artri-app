import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Exercícios físicos',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const Gap(16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Informações',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const Gap(16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF03A64A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Relaxamento',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: AppColors.darkGreen,
    //     title: const Text(
    //       'Exercícios',
    //     ),
    //     centerTitle: true,
    //     titleTextStyle: GoogleFonts.montserrat(
    //       textStyle: const TextStyle(
    //         color: Colors.white,
    //         fontWeight: FontWeight.w600,
    //         fontSize: 36,
    //       ),
    //     ),
    //     leading: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Container(
    //         width: 48,
    //         height: 48,
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           border: Border.all(
    //             color: Colors.white,
    //             width: 2.0,
    //           ),
    //         ),
    //         child: const Center(
    //           child: Icon(
    //             Icons.arrow_back,
    //             color: Colors.white,
    //             size: 24,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         ElevatedButton(
    //           onPressed: () {},
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: Color(0xFF03A64A),
    //             padding:
    //                 const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    //             fixedSize: const Size(300, 50),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16),
    //             ),
    //           ),
    //           child: const Text(
    //             'Exercícios físicos',
    //             style: TextStyle(
    //               fontSize: 24,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //         const Gap(16),
    //         ElevatedButton(
    //           onPressed: () {},
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: Color(0xFF03A64A),
    //             padding:
    //                 const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    //             fixedSize: const Size(300, 50),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16),
    //             ),
    //           ),
    //           child: const Text(
    //             'Informações',
    //             style: TextStyle(
    //               fontSize: 24,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //         const Gap(16),
    //         ElevatedButton(
    //           onPressed: () {},
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: Color(0xFF03A64A),
    //             padding:
    //                 const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    //             fixedSize: const Size(300, 50),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16),
    //             ),
    //           ),
    //           child: const Text(
    //             'Relaxamento',
    //             style: TextStyle(
    //               fontSize: 24,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   bottomNavigationBar: NavBar(),
    //);
  }
}
