import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectDate!);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            controller: _valueController,
            textInputAction: TextInputAction.done,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (value) => _submitForm(),
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectDate == null
                      ? 'Nenhuma data selecionada!'
                      : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectDate!)}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                    onPressed: _showDatePicker, child: const Text('Selecionar Data'))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _submitForm,
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 189, 152, 195))),
                child: const Text('Nova Transação', ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
