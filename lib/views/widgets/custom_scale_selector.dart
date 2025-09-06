import 'package:flutter/material.dart';

class CustomScaleSelectorWidget extends StatefulWidget {
  final int? initialValue;
  final void Function(int selectedLevel)? onChanged;
  final String? label;

  const CustomScaleSelectorWidget({
    super.key,
    this.initialValue,
    this.onChanged,
    this.label,
  });

  @override
  _CustomScaleSelectorWidgetState createState() =>
      _CustomScaleSelectorWidgetState();
}

class _CustomScaleSelectorWidgetState extends State<CustomScaleSelectorWidget> {
  late int selectedLevel;

  @override
  void initState() {
    super.initState();
    selectedLevel = widget.initialValue ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(11, (index) {
            final isSelected = selectedLevel == index;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: AspectRatio(
                  aspectRatio:
                      1, // garante que o botão seja quadrado (círculo perfeito)
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedLevel = index;
                        widget.onChanged?.call(index);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor:
                          isSelected ? Colors.green : Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.zero, // sem padding interno
                    ),
                    child: Text('$index'),
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 24),
        Text(
          widget.label == "Fadiga"
              ? _getFatigueLabel(selectedLevel)
              : _getSleepLabel(selectedLevel),
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  String _getFatigueLabel(int level) {
    if (level == -1) return 'Selecione um nível';
    if (level == 0) return 'Nenhuma';
    if (level <= 3) return 'Fadiga leve';
    if (level <= 6) return 'Fadiga média';
    if (level <= 9) return 'Fadiga forte';
    return 'Excessiva';
  }

  String _getSleepLabel(int level) {
    if (level == -1) return 'Selecione um nível';
    if (level == 0) return 'Muito ruim';
    if (level <= 3) return 'Sono ruim';
    if (level <= 6) return 'Sono razoável';
    if (level <= 9) return 'Sono bom';
    return 'Excelente';
  }
}
