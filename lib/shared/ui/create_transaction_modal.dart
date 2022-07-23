import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/ui/ui.dart';
import '../../../models/models.dart';

class CreateTransactionModal extends StatefulWidget {
  static void open(BuildContext context, void Function(MyTransaction) addNewTransaction) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext bottomSheetContext) => CreateTransactionModal(addNewTransaction),
    );
  }

  final void Function(MyTransaction) addNewTransaction;
  const CreateTransactionModal(this.addNewTransaction, {Key? key}) : super(key: key);

  @override
  State<CreateTransactionModal> createState() => _CreateTransactionModalState();
}

class _CreateTransactionModalState extends State<CreateTransactionModal> {
  final _titleConroller = TextEditingController(text: 'Title text');
  final _amountConroller = TextEditingController(text: '234');

  var _transactionType = MyTransactionDataType.expanse;
  DateTime _choosenDate = DateTime.now();

  void _onSubmitData() {
    if (_titleConroller.text.isEmpty || _amountConroller.text.isEmpty) return;
    final title = _titleConroller.text;
    final amount = double.parse(_amountConroller.text);
    if (title.isEmpty || amount <= 0) {
      return;
    }
    final newTx = MyTransaction(
      title: title,
      amount: amount,
      createdAt: _choosenDate,
      type: _transactionType,
    );
    widget.addNewTransaction(newTx);
  }

  void _onShowDatePicker() {
    final DateTime today = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year),
      lastDate: today,
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _choosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        padding: const EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.grey.shade100,
        ),
        child: Column(
          children: <Widget>[
            const Text(
              'Create New Transaction',
              style: TextStyle(fontSize: 22),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'What is the reason of your expanse?',
                    ),
                    controller: _titleConroller,
                    /* onSubmitted: (_) => _onSubmitData(), */
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'What is the amount of your expanse?',
                    ),
                    controller: _amountConroller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.date_range,
                        size: 28,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          DateFormat.yMEd().format(_choosenDate),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      TextButton(
                        onPressed: _onShowDatePicker,
                        child: const Text('Change Date'),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  CustomSwitch<MyTransactionDataType>(
                    onSelect: (selected) => _transactionType = selected,
                    optionNames: const ['Expanse', 'Income'],
                    options: const [MyTransactionDataType.expanse, MyTransactionDataType.income],
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: SizedBox(
                      width: 240,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onSubmitData,
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          'Add transaction',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
