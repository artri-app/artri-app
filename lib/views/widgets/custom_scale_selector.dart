import 'package:flutter/material.dart';

class CustomScaleSelectorWidget extends StatefulWidget {
  final int? initialValue;
  final void Function(int selectedLevel)? onChanged;
  final String minLabel;
  final String maxLabel;

  const CustomScaleSelectorWidget({
    super.key,
    this.initialValue,
    this.onChanged,
    this.minLabel = '',
    this.maxLabel = '',
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
        Row(
          children: List.generate(11, (index) {
            if (index == 0) {
              return Expanded(
                child: Text(
                  widget.minLabel,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (index == 10) {
              return Expanded(
                child: Text(
                  widget.maxLabel,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return const Expanded(child: SizedBox());
          }),
        ),
      ],
    );
  }
}
