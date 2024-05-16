import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropdownMenu extends StatefulWidget {
  CustomDropdownMenu({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.width = 390,
    this.borderColor = Colors.grey,
  });

  final List<String> options;
  String? selected;
  final void Function(String? newValue) onChanged;
  final double width;
  final Color borderColor;

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  @override
  void initState() {
    widget.selected = widget.options.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.borderColor,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 12,
          ),
          child: DropdownButton<String>(
            value: widget.selected,
            icon: const SizedBox(),
            borderRadius: BorderRadius.circular(12),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              widget.onChanged(newValue);
            },
            items: widget.options.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
