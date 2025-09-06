import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxGroup extends StatefulWidget {
  final Function(List<String>) onChanged;

  const CheckboxGroup({required this.onChanged});

  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  final Map<String, bool> _items = {
    "Mãos": false,
    "Braço": false,
    "Ombro": false,
    "Coluna": false,
    "Quadril": false,
    "Joelho": false,
    "Tornozelo": false,
    "Pés": false,
  };

  void _updateSelection() {
    List<String> selecionados =
        _items.entries.where((e) => e.value).map((e) => e.key).toList();
    widget.onChanged(selecionados);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _items.keys.map((String key) {
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
              Text(key,
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
