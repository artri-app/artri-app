import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/view_models/calendar.view_model.dart';
import 'package:artriapp/views/widgets/custom_solid_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddReminderDialog extends StatelessWidget {
  const AddReminderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.darkGreen,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        child: Consumer<CalendarViewModel>(
          builder: (context, viewModel, _) => SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(children: [
              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 32),
                    Text(
                      'Adicionar lembrete',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: AppColors.neutral,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 32, color: AppColors.neutral),
                      onPressed: () {
                        viewModel.resetNewReminder();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              const Gap(16),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
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
                          ],
                        ),
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
                        CustomSolidButton(
                          text: 'Confirmar',
                          color: AppColors.mediumGreen,
                          onPressed: () {
                            viewModel.addReminder();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],),
          ),
        )
      ),
);
  }
}