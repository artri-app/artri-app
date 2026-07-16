import 'package:artriapp/models/api_responses/remedy.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/remedy_view_model.dart';
import 'package:artriapp/views/widgets/custom_solid_button.dart';
import 'package:artriapp/views/widgets/form_text_field.dart';
import 'package:artriapp/views/widgets/time_field.dart';
import 'package:artriapp/views/widgets/weekday_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddRemedyPage extends StatefulWidget {
  final Remedy? remedy;

  const AddRemedyPage({super.key, this.remedy});

  @override
  State<AddRemedyPage> createState() => _AddRemedyPageState();
}

class _AddRemedyPageState extends State<AddRemedyPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  TimeOfDay? _selectedTime;
  Set<DaysOfWeek> _selectedDays = {};
  bool? _reminderEnabled;

  bool get _isEditing => widget.remedy != null;

  @override
  void initState() {
    super.initState();

    final remedy = widget.remedy;
    if (remedy != null) {
      _nameController.text = remedy.name;
      _dosageController.text = remedy.quantity;
      _selectedTime = _parseHour(remedy.hour);
      _selectedDays = remedy.daysOfWeek.toSet();
      _reminderEnabled = remedy.reminderEnabled;
    }
  }

  TimeOfDay? _parseHour(String hour) {
    final parts = hour.split(':');
    if (parts.length < 2) return null;

    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione ao menos um dia da semana.'),
        ),
      );
      return;
    }

    if (_reminderEnabled == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione se deseja receber lembrete.'),
        ),
      );
      return;
    }

    final name = _nameController.text;
    final dosage = _dosageController.text;
    final hour = _selectedTime != null
        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
        : '';

    final viewModel = context.read<RemedyViewModel>();

    if (_isEditing) {
      viewModel.updateRemedy(
        id: widget.remedy!.id,
        name: name,
        quantity: dosage,
        hour: hour,
        daysOfWeek: _selectedDays,
        reminderEnabled: _reminderEnabled!,
      );
    } else {
      viewModel.addRemedy(
        name: name,
        quantity: dosage,
        hour: hour,
        daysOfWeek: _selectedDays,
        reminderEnabled: _reminderEnabled!,
      );
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _isEditing ? 'Editar Medicamento' : 'Adicionar Medicamentos',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkGreen),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormTextField(
              label: 'Nome:',
              placeholder: 'Ex: Dipirona',
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            FormTextField(
              label: 'Dosagem:',
              placeholder: 'Ex: 500mg, 2 comprimidos',
              controller: _dosageController,
            ),
            const SizedBox(height: 20),
            TimeField(
              label: 'Horário:',
              value: _selectedTime,
              onChanged: (time) => setState(() => _selectedTime = time),
            ),
            const SizedBox(height: 20),
            WeekdaySelector(
              label: 'Dias da semana:',
              selectedDays: _selectedDays,
              onChanged: (days) => setState(() => _selectedDays = days),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                Text(
                  'Deseja Criar Lembrete?',
                  style: GoogleFonts.montserrat(
                    color: AppColors.darkGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _ReminderOptionButton(
                        label: 'Sim',
                        selected: _reminderEnabled == true,
                        onTap: () => setState(() => _reminderEnabled = true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ReminderOptionButton(
                        label: 'Não',
                        selected: _reminderEnabled == false,
                        onTap: () => setState(() => _reminderEnabled = false),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 48),
            Center(
              child: CustomSolidButton(
                text: _isEditing ? 'Atualizar' : 'Salvar',
                width: double.infinity,
                onPressed: () async => _handleSave(),
                borderRadius: 20,
                gradientColors: const [
                  Color.fromARGB(255, 3, 166, 74),
                  Color.fromARGB(255, 4, 191, 138),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderOptionButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ReminderOptionButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.darkGreen : AppColors.neutral,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            color: selected ? Colors.white : AppColors.darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
