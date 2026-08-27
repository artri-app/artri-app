import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/view_models/calendar_view_model.dart';
import 'package:artriapp/views/widgets/add_reminder_dialog.dart';
import 'package:artriapp/views/widgets/calendar_reminder.dart';
import 'package:artriapp/views/widgets/custom_solid_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {

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
          'NOVO LEMBRETE',
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
                Icons.close_rounded,
                color: AppColors.darkGreen,
                size: 24,
              ),
            ),
          ),
        ),
        body: Consumer<CalendarViewModel>(
          builder: (context, viewModel, _) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Gap(16),
                    Text(
                      'Descreva o lembrete em poucas palavras',
                      style: GoogleFonts.montserrat(fontSize: 20),
                    ),
                    const Gap(16),
                    SizedBox(
                      height: 160,
                      child: TextField(
                        maxLines: 10,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        onChanged: (value) {
                          viewModel.setRemiderMessageValue(value);
                        },
                      ),
                    ),
                    const Gap(32),
                    GestureDetector(
                      onTap: () async {
                        DateTime currentTime = DateTime.now();
                        DateTime? newTime = await showDialog(context: context, builder: (context) => 
                          DatePickerDialog(
                            restorationId: 'date_picker_dialog',
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            initialDate: currentTime,
                            firstDate: currentTime,
                            lastDate: DateTime(currentTime.year + 5),
                          ),
                        );
                        if (newTime != null) {
                          viewModel.setNewDate(newTime);
                        }
                      },
                      child: SizedBox(
                          height: 64,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${viewModel.newReminderDateTime.day}/${viewModel.newReminderDateTime.month}/${viewModel.newReminderDateTime.year}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: CustomSolidButton(
                    text: 'Confirmar',
                    color: AppColors.mediumGreen,
                    onPressed: () {
                      viewModel?.addReminder();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}