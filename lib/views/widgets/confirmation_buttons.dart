import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';

class ConfirmationButtons extends StatelessWidget {
  final ValueChanged<ConfirmationAction> onButtonClicked;
  final bool isConfirmEnabled;
  final String confirmText;

  const ConfirmationButtons({super.key, required this.onButtonClicked, this.isConfirmEnabled = true, this.confirmText = 'Salvar'});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomSolidButton(
          text: 'Voltar',
          onPressed: () => onButtonClicked.call(ConfirmationAction.canceled),
          gradientColors: AppGradients.redGradient,
        ),
        CustomSolidButton(
          text: confirmText,
          onPressed: isConfirmEnabled
              ? () => onButtonClicked.call(ConfirmationAction.confirmed)
              : null,
          gradientColors: AppGradients.greenGradient,
        ),
      ],
    );
  }
}
