import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Map<DaysOfWeek, String> _dayLabels = {
  DaysOfWeek.monday: 'S',
  DaysOfWeek.tuesday: 'T',
  DaysOfWeek.wednesday: 'Q',
  DaysOfWeek.thursday: 'Q',
  DaysOfWeek.friday: 'S',
  DaysOfWeek.saturday: 'S',
  DaysOfWeek.sunday: 'D',
};

class WeekdaySelector extends StatelessWidget {
  final String label;
  final Set<DaysOfWeek> selectedDays;
  final ValueChanged<Set<DaysOfWeek>> onChanged;

  const WeekdaySelector({
    super.key,
    required this.label,
    required this.selectedDays,
    required this.onChanged,
  });

  void _toggle(DaysOfWeek day) {
    final updated = Set<DaysOfWeek>.from(selectedDays);
    updated.contains(day) ? updated.remove(day) : updated.add(day);
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: AppColors.darkGreen,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: DaysOfWeek.values.map((day) {
            final isSelected = selectedDays.contains(day);
            return GestureDetector(
              onTap: () => _toggle(day),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.darkGreen : AppColors.neutral,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Text(
                    _dayLabels[day]!,
                    style: GoogleFonts.montserrat(
                      color: isSelected ? Colors.white : AppColors.darkGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
