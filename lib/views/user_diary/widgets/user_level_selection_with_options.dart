import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/view_models/evolution_view_model.dart';
import 'package:artriapp/views/user_diary/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  String? _selectedOption;

  void handleRadioChange(String? value) {
    setState(() {
      _selectedOption = value;
      selectedInfos.clear();
      if (value != null) {
        selectedInfos[value] = -1;
      }
    });
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
      onLevelSelected: (value) => setState(() {
        selectedInfos[option] = value;
      }),
      selectedLevel: selectedInfos[option] == -1 ? null : selectedInfos[option],
      minLabel: getMinLabel(),
      maxLabel: getMaxLabel(),
    );
  }

  String getUserSelectionDescription(String option) {
    switch (widget.title.toLowerCase()) {
      case 'inchaço':
        return 'De 0 a 10, qual o nível de ${widget.title} ${getStringArticle(option)} $option?';
      case 'dor':
        return 'De 0 a 10, qual o nível da sua ${widget.title} ${getStringArticle(option)} $option?';
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
    return Consumer<EvolutionViewModel>(
      builder: (context, viewModel, child) {

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                      size: 24,
                    ),
                    widget.tooltipMessage != null
                        ? HintIndicatorTooltip(
                      tooltipMessage: widget.tooltipMessage!,
                    )
                        : const Gap(0),
                  ],
                ),
                Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      children: BodyOptions.values.map((option) {
                        return GestureDetector(
                          onTap: () => handleRadioChange(option.toString()),
                          child: Row(
                            children: [
                              Radio<String>(
                                value: option.toString(),
                                groupValue: _selectedOption,
                                onChanged: handleRadioChange,
                                activeColor: Colors.green,
                              ),
                              Flexible(
                                child: Text(
                                  option.toString(),
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedInfos.keys.length,
                      itemBuilder: (context, idx) =>
                          renderUserSelection(context, idx),
                    ),
                    const Gap(32),
                    ConfirmationButtons(
                      isConfirmEnabled: _selectedOption != null &&
                          selectedInfos[_selectedOption] != -1,
                      onButtonClicked: (action) {
                        if (action == ConfirmationAction.confirmed) {
                          if (widget.title == DiaryOptions.pain.toString()) {
                            viewModel.addPainLevel(_selectedOption, selectedInfos[_selectedOption]);
                          } else if (widget.title == DiaryOptions.swelling.toString()) {
                            viewModel.addSwellingLevel(_selectedOption, selectedInfos[_selectedOption]);
                          }
                        }
                        context.pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

      },
    );
  }
}
