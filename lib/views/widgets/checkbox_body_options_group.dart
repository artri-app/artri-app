import 'package:artriapp/utils/enums/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxBodyOptionsGroup extends StatefulWidget {
  final Function(List<BodyOptions>) onChanged;

  const CheckboxBodyOptionsGroup({super.key, required this.onChanged});

  @override
  _CheckboxBodyOptionsGroupState createState() =>
      _CheckboxBodyOptionsGroupState();
}

class _CheckboxBodyOptionsGroupState extends State<CheckboxBodyOptionsGroup> {
  final Map<BodyOptions, bool> _items = {
    BodyOptions.hands: false,
    BodyOptions.arm: false,
    BodyOptions.shoulder: false,
    BodyOptions.column: false,
    BodyOptions.hip: false,
    BodyOptions.knee: false,
    BodyOptions.ankle: false,
    BodyOptions.feet: false,
  };

  void _updateSelection() {
    List<BodyOptions> selecionados =
        _items.entries.where((e) => e.value).map((e) => e.key).toList();

    widget.onChanged(selecionados);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 4,
      children: _items.keys.map((BodyOptions key) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _items[key] = !_items[key]!;
              _updateSelection();
            });
          },
          child: Row(
            children: [
              Checkbox(
                value: _items[key],
                onChanged: (bool? value) {
                  setState(() {
                    _items[key] = value!;
                    _updateSelection();
                  });
                },
                activeColor: Colors.green,
                checkColor: Colors.white,
                side:
                    const BorderSide(color: Color.fromARGB(255, 93, 196, 190)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              Text(
                key.toString(),
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
