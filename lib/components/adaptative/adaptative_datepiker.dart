import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePiker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativeDatePiker({
    Key? key,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: selectedDate,
        minimumDate: DateTime(2022),
        maximumDate: DateTime.now(),
        onDateTimeChanged: (pickedDate) {
          onDateChanged(pickedDate);
        }
      ),
    ) : SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // ignore: unnecessary_null_comparison
                      selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                        onPressed: () => _showDatePicker(context),
                        child: const Text('Selecionar Data'))
                  ],
                ),
              );
  }
}
