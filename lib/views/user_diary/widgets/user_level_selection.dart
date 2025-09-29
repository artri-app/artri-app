import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserLevelSelection extends StatelessWidget {
  final String? title;
  final String description;
  final String? hintDescription;
  final int? selectedLevel;
  final ValueChanged<int>? onLevelSelected;
  final bool showButtons;
  final String? tooltipMessage;

  const UserLevelSelection({
    super.key,
    required this.description,
    this.selectedLevel,
    this.showButtons = true,
    this.title,
    this.onLevelSelected,
    this.hintDescription,
    this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            title != null
                ? Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SessionTitle(title: title!),
                      tooltipMessage != null
                          ? HintIndicatorTooltip(
                              tooltipMessage: tooltipMessage!)
                          : Gap(0),
                    ],
                  )
                : const Gap(0),
            SizedBox(height: 16),
            Text(
              description.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            CustomScaleSelectorWidget(
              onChanged: (value) {
                onLevelSelected?.call(value);
              },
              initialValue: selectedLevel,
            ),
          ],
        ),
        Builder(
          builder: (context) {
            if (showButtons) {
              return Column(
                children: [
                  Gap(32),
                  ConfirmationButtons(
                    onButtonClicked: (action) =>
                        action == ConfirmationAction.canceled
                            ? context.pop()
                            : null,
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
