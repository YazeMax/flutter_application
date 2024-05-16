// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';

class DateSelectionButton extends StatefulWidget {
  DateSelectionButton({
    super.key,
    this.date,
    this.title = "Selecione a data",
    required this.onTap,
  });

  DateTime? date;
  // final DateTime firstDate;
  // final DateTime lastDate;
  final String title;
  final void Function(DateTime) onTap;

  @override
  State<DateSelectionButton> createState() => _DateSelectionButtonState();
}

class _DateSelectionButtonState extends State<DateSelectionButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ElevatedButton.icon(
        onPressed: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            firstDate: DateTime(1980),
            lastDate: DateTime(2030),
          );
          if (pickedDate != null) {
            widget.onTap(pickedDate);
          }
        },
        icon: const Icon(Icons.calendar_month),
        label: SizedBox(
          height: 55,
          child: Center(
            child: Text(
              "${widget.title}\n${widget.date?.day} / ${widget.date?.month} / ${widget.date?.year}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(color: Colors.black38),
            ),
          ),
        ),
      ),
    );
  }
}
