import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:artriapp/view_models/index.dart';
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
  final String minLabel;
  final String maxLabel;

  const UserLevelSelection({
    super.key,
    required this.description,
    this.selectedLevel,
    this.showButtons = true,
    this.title,
    this.onLevelSelected,
    this.hintDescription,
    this.tooltipMessage,
    this.minLabel = '',
    this.maxLabel = '',
  });

  @override
  State<UserLevelSelection> createState() => _UserLevelSelection();
}

class _UserLevelSelection extends State<UserLevelSelection> {
  int? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selectedLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EvolutionViewModel>(
      builder: (context, viewModel, child) {
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
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                CustomScaleSelectorWidget(
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                    widget.onLevelSelected?.call(value);
                  },
                  initialValue: _currentValue,
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
                        isConfirmEnabled: _currentValue != null,
                        onButtonClicked: (action) {
                          if (action == ConfirmationAction.confirmed &&
                              _currentValue != null) {
                            if (widget.title ==
                                DiaryOptions.fatigue.toString()) {
                              viewModel.addFatigueLevel(_currentValue, null);
                            } else if (widget.title ==
                                DiaryOptions.sleep.toString()) {
                              viewModel.addSleepLevel(_currentValue, null);
                            }
                            widget.onLevelSelected?.call(_currentValue!);
                          }
                          context.pop();
                        },
                      ),
                    ],
                  );
                }
                return Gap(0);
              },
            ),
          ],
        );
      },
    );
  }
}
