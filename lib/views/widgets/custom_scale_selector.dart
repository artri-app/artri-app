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
  State<CustomScaleSelectorWidget> createState() =>
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 360;

        return Column(
          children: [
            const SizedBox(height: 20),
            if (isCompact)
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  11,
                  (index) => _buildScaleButton(index, compact: true),
                ),
              )
            else
              Row(
                children: List.generate(
                  11,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: _buildScaleButton(index),
                      ),
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(widget.minLabel, textAlign: TextAlign.left),
                ),
                Flexible(
                  child: Text(widget.maxLabel, textAlign: TextAlign.right),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildScaleButton(int index, {bool compact = false}) {
    final isSelected = selectedLevel == index;

    final button = ElevatedButton(
      onPressed: () {
        setState(() => selectedLevel = index);
        widget.onChanged?.call(index);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: isSelected ? Colors.green : Colors.grey[300],
        foregroundColor: Colors.black,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
      child: Text('$index'),
    );

    return compact ? SizedBox(width: 36, height: 36, child: button) : button;
  }
}
