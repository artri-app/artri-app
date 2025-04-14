import 'package:flutter/material.dart';

class PainScaleSelectorWidget extends StatefulWidget {
  final int? initialValue;
  final void Function(int selectedLevel)? onChanged;

  const PainScaleSelectorWidget({
    Key? key,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _PainScaleSelectorWidgetState createState() =>
      _PainScaleSelectorWidgetState();
}

class _PainScaleSelectorWidgetState extends State<PainScaleSelectorWidget> {
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
          _getPainLabel(selectedLevel),
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  String _getPainLabel(int level) {
    if (level == -1) return 'Selecione um nível';
    if (level == 0) return 'Sem dor';
    if (level <= 3) return 'Dor leve';
    if (level <= 6) return 'Dor média';
    if (level <= 9) return 'Dor forte';
    return 'Máximo de dor';
  }
}
