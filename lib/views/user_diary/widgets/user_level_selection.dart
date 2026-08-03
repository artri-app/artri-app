import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserLevelSelection extends StatefulWidget {
  final String? title;
  final String description;
  final String? hintDescription;
  final int? selectedLevel;
  final ValueChanged<int>? onLevelSelected;
  final bool showButtons;
  final String? tooltipMessage;
  final String? tooltipTitle;
  final String minLabel;
  final String maxLabel;
  final DiaryMetric? metric;

  const UserLevelSelection({
    super.key,
    required this.description,
    this.selectedLevel,
    this.showButtons = true,
    this.title,
    this.onLevelSelected,
    this.hintDescription,
    this.tooltipMessage,
    this.tooltipTitle,
    this.minLabel = '',
    this.maxLabel = '',
    this.metric,
  }) : assert(
          !showButtons || metric != null,
          'Informe a métrica para poder salvar o registro.',
        );

  @override
  State<UserLevelSelection> createState() => _UserLevelSelectionState();
}

class _UserLevelSelectionState extends State<UserLevelSelection> {
  int? selectedLevel;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    selectedLevel = widget.selectedLevel;
  }

  void handleLevelSelected(int level) {
    selectedLevel = level;
    widget.onLevelSelected?.call(level);
  }

  Future<void> onConfirmationAction(ConfirmationAction action) async {
    if (action == ConfirmationAction.canceled) {
      closeSelection();
      return;
    }

    if (selectedLevel == null) {
      showMessage('Escolha um número de 0 a 10 antes de salvar.');
      return;
    }

    if (isSaving) return;

    setState(() => isSaving = true);

    bool saved = await context.read<DiaryViewModel>().enviarRelatorio(
          metrica: widget.metric!,
          nivel: selectedLevel!,
        );

    if (!mounted) return;

    setState(() => isSaving = false);

    if (!saved) {
      showMessage('Não foi possível salvar agora. Tente novamente.');
      return;
    }

    showMessage('Registro de ${widget.title} salvo!');
    closeSelection();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void closeSelection() {
    if (context.canPop()) {
      context.pop();
      return;
    }

    context.go(UserDiaryRoutes.diary);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            widget.title != null
                ? Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SessionTitle(title: widget.title!),
                      widget.tooltipMessage != null
                          ? HintIndicatorTooltip(
                              tooltipMessage: widget.tooltipMessage!,
                              tooltipTitle: widget.tooltipTitle,
                            )
                          : Gap(0),
                    ],
                  )
                : const Gap(0),
            SizedBox(height: 16),
            Text(
              widget.description.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                height: 1.25,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            CustomScaleSelectorWidget(
              onChanged: handleLevelSelected,
              initialValue: selectedLevel,
              minLabel: widget.minLabel,
              maxLabel: widget.maxLabel,
            ),
          ],
        ),
        Builder(
          builder: (context) {
            if (widget.showButtons) {
              return Column(
                children: [
                  Gap(32),
                  ConfirmationButtons(
                    onButtonClicked: onConfirmationAction,
                  ),
                ],
              );
            }
            return Gap(0);
          },
        ),
      ],
    );
  }
}
