import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/view_models/calendar_view_model.dart';
import 'package:artriapp/views/widgets/add_reminder_dialog.dart';
import 'package:artriapp/views/widgets/calendar_reminder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  void initState() {
    context.read<CalendarViewModel>().getLocallySavedReminders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarViewModel>(
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'AGENDA',
          style: GoogleFonts.montserrat(
            fontSize: 26,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton.outlined(
            onPressed: () =>
                context.canPop() ? context.pop() : context.go('/diary'),
              style: ButtonStyle(
                side: WidgetStatePropertyAll(
                  const BorderSide(color: AppColors.darkGreen, width: 2),
                ),
              ),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.darkGreen,
                size: 24,
              ),
            ),
          ),
        ),
        body: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 124,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Gap(64),
                        SizedBox(
                          height: 132.0 * viewModel.calendarReminders.length,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: viewModel.calendarReminders.length,
                            itemBuilder: (context, index) {
                              return CalendarReminder(
                                isEven: viewModel.calendarReminders[index].date?.day.remainder(2) == 0,
                                diaryReminder: viewModel.calendarReminders[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: FloatingActionButton(
                      backgroundColor: AppColors.mediumGreen,
                      child: Icon(Icons.add_outlined, color: AppColors.neutral, size: 40,),
                      onPressed: () {
                        showDialog(
                          context: (context),
                          builder: (context) => AddReminderDialog());
                        // viewModel.saveReminderListLocally();
                  }),)
                ],
              ),
            ),
        ),
      ),
    );
  }
}