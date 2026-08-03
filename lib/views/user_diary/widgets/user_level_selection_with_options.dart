import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/user_diary/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserLevelSelectionWithOptions extends StatefulWidget {
  final String title;
  final DiaryMetric metric;
  final String? tooltipMessage;
  final String? tooltipTitle;

  const UserLevelSelectionWithOptions({
    super.key,
    required this.title,
    required this.metric,
    this.tooltipMessage,
    this.tooltipTitle,
  });

  @override
  State<UserLevelSelectionWithOptions> createState() =>
      _UserLevelSelectionWithOptionsState();
}

class _UserLevelSelectionWithOptionsState
    extends State<UserLevelSelectionWithOptions> {
  Map<String, int?> selectedInfos = <String, int?>{};
  bool isSaving = false;

  void onCheckBoxChanged(List<String> options) {
    for (String option in options) {
      if (selectedInfos.containsKey(option)) continue;

      selectedInfos[option] = -1;
    }

    List<String> selectedInfosKeys = selectedInfos.keys.toList();

    for (String key in selectedInfosKeys) {
      if (options.contains(key)) continue;

      selectedInfos.remove(key);
    }
  }

  String getMinLabel() {
    switch (widget.title.toLowerCase()) {
      case 'dor':
        return 'Nenhuma';

      case 'inchaço':
        return 'Nenhum';

      default:
        return '';
    }
  }

  String getMaxLabel() {
    switch (widget.title.toLowerCase()) {
      case 'dor':
        return 'Intensa';

      case 'inchaço':
        return 'Intenso';

      default:
        return '';
    }
  }

  Widget renderUserSelection(BuildContext context, int idx) {
    String option = selectedInfos.keys.elementAt(idx);

    return UserLevelSelection(
      key: Key('$option - ${selectedInfos[option]}'),
      description: getUserSelectionDescription(option),
      showButtons: false,
      onLevelSelected: (value) => selectedInfos[option] = value,
      selectedLevel: selectedInfos[option] == -1 ? null : selectedInfos[option],
      minLabel: getMinLabel(),
      maxLabel: getMaxLabel(),
    );
  }

  String getUserSelectionDescription(String option) {
    switch (widget.title.toLowerCase()) {
      case 'inchaço':
        return 'De 0 a 10, qual nível de ${widget.title} ${getStringArticle(option)} $option';
      case 'dor':
        return 'De 0 a 10, qual nível da sua ${widget.title} ${getStringArticle(option)} $option';
      default:
        return 'Option not defined';
    }
  }

  String getStringArticle(String option) {
    switch (option.toLowerCase()) {
      case 'coluna':
        return 'na';
      case 'mãos':
        return 'nas';
      case 'pés':
        return 'nos';
      default:
        return 'no';
    }
  }

  Future<void> onConfirmationAction(ConfirmationAction action) async {
    if (action == ConfirmationAction.canceled) {
      closeSelection();
      return;
    }

    if (selectedInfos.isEmpty) {
      showMessage('Selecione ao menos uma região antes de salvar.');
      return;
    }

    List<String> missingLevels = selectedInfos.entries
        .where((info) => info.value == null || info.value == -1)
        .map((info) => info.key)
        .toList();

    if (missingLevels.isNotEmpty) {
      String pendingRegions = missingLevels.join(', ');

      showMessage('Escolha um número de 0 a 10 para: $pendingRegions.');
      return;
    }

    if (isSaving) return;

    setState(() => isSaving = true);

    Map<String, int> levelsByRegion = {
      for (MapEntry<String, int?> info in selectedInfos.entries)
        info.key: info.value!,
    };

    bool saved = await context.read<DiaryViewModel>().enviarRelatorioPorRegiao(
          metrica: widget.metric,
          niveisPorRegiao: levelsByRegion,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              SessionTitle(
                title: widget.title,
              ),
              widget.tooltipMessage != null
                  ? HintIndicatorTooltip(
                      tooltipMessage: widget.tooltipMessage!,
                      tooltipTitle: widget.tooltipTitle,
                    )
                  : Gap(0),
            ],
          ),
          CheckboxGroup(
            onChanged: (list) => setState(() {
              onCheckBoxChanged(list);
            }),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: selectedInfos.keys.length,
            itemBuilder: (context, idx) => renderUserSelection(context, idx),
          ),
          Gap(32),
          ConfirmationButtons(
            onButtonClicked: onConfirmationAction,
          ),
        ],
      ),
    );
  }
}
