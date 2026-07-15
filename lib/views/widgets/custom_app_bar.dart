import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function? onReturn;
  final String value;
  CustomAppBar({required this.value, this.onReturn, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      toolbarHeight: 80,
      leadingWidth: 64,
      leading: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16, left:16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(width: 1, color: AppColors.darkBlue,),
          ),
          child: IconButton(
            onPressed: () => (onReturn != null ) ? onReturn!() : 
              GoRouter.of(context).pop(),

            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.darkBlue,
            ),
          ),
        ),
      ),
      actions: const [
        SizedBox(width:16),
      ],
      centerTitle: true,
      actionsPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      title: Text(
        value,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 32,
          color: AppColors.darkBlue,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}