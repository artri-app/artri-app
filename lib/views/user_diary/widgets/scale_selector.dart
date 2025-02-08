import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScaleSelector extends StatefulWidget {
  final int selectedOption;
  final String label;

  const ScaleSelector(
      {super.key, this.selectedOption = 0, this.label = 'label'});

  @override
  State<ScaleSelector> createState() => _ScaleSelectorState();
}

class _ScaleSelectorState extends State<ScaleSelector> {
  int _selectedScale = 0;
  String _label = 'Label';

  List<Widget> _createScaleWidgets() {
    List<Widget> widgets = List.empty(growable: true);

    for (int i = 0; i < 5; i++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => {
              setState(
                () {
                  _selectedScale = i;
                },
              )
            },
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selectedScale == i
                    ? const Color(0xff03a64a)
                    : const Color(0xffefecea),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                (i + 1).toString(),
                style: GoogleFonts.openSans(
                  color: const Color(0xff025940),
                  fontWeight:
                      _selectedScale == i ? FontWeight.bold : FontWeight.normal,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  void initState() {
    _selectedScale = widget.selectedOption;
    _label = widget.label;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _label.toUpperCase(),
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Color(0xff026873),
              fontSize: 28,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _createScaleWidgets(),
        )
      ],
    );
  }
}
