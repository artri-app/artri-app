import 'package:artriapp/models/diary_reminder.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarReminder extends StatelessWidget {
  final bool isEven;
  final DiaryReminder diaryReminder;
  const CalendarReminder({required this.isEven, required this.diaryReminder, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            mainAxisAlignment: isEven ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isEven) ...[
                SizedBox(child: !isEven ? _dayWidget() : null),
                Gap(!isEven ? 16 : 0),
              ],
              Flexible(
                child: Text(
                  diaryReminder.message ?? '',
                  maxLines: 3,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                  ),
                ),
              ),
              if (isEven) ...[
                Gap(isEven ? 16 : 0),
                SizedBox(child: isEven ? _dayWidget() : null),
              ]
            ],
          ),
        ),
      ],
    );
  }
    Widget _dayWidget() {

    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.darkGreen,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      diaryReminder.date?.day.toString() ?? '',
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.neutral,
                      ),
                    ),
                    Text(
                      diaryReminder.getMonthName().substring(0, 3),   
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

