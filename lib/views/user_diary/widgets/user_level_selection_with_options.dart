import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/views/user_diary/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class UserLevelSelectionWithOptions extends StatefulWidget {
  final String title;
  final String? tooltipMessage;

  const UserLevelSelectionWithOptions({
    super.key,
    required this.title,
    this.tooltipMessage,
  });

  @override
  State<UserLevelSelectionWithOptions> createState() =>
      _UserLevelSelectionWithOptionsState();
}

class _UserLevelSelectionWithOptionsState
    extends State<UserLevelSelectionWithOptions> {
  Map<String, int?> selectedInfos = <String, int?>{};

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

  Widget renderUserSelection(BuildContext context, int idx) {
    String option = selectedInfos.keys.elementAt(idx);

    return UserLevelSelection(
      key: Key('$option - ${selectedInfos[option]}'),
      description: getUserSelectionDescription(option),
      showButtons: false,
      onLevelSelected: (value) => selectedInfos[option] = value,
      selectedLevel: selectedInfos[option] == -1 ? null : selectedInfos[option],
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
            scrollDirection: Axis.vertical,
            itemCount: selectedInfos.keys.length,
            itemBuilder: (context, idx) => renderUserSelection(context, idx),
          ),
          Gap(32),
          ConfirmationButtons(
            onButtonClicked: (action) =>
                action == ConfirmationAction.canceled ? context.pop() : null,
          ),
        ],
      ),
    );
  }
}
