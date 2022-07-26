import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/models.dart';
import '../../../shared/ui/ui.dart';

class CreateTransactionModal extends StatefulWidget {
  final void Function(MyTransaction) addNewTransaction;
  const CreateTransactionModal(this.addNewTransaction, {Key? key}) : super(key: key);

  @override
  State<CreateTransactionModal> createState() => _CreateTransactionModalState();

  static void open(BuildContext context, void Function(MyTransaction) addNewTransaction) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext bottomSheetContext) => CreateTransactionModal(addNewTransaction),
    );
  }
}

class _CreateTransactionModalState extends State<CreateTransactionModal> {
  final _descriptionTextConroller = TextEditingController(text: 'Title text');
  final _amountConroller = TextEditingController(text: '234');
  TransactionCategory? _transactionCategory;
  var _transactionType = MyTransactionDataType.expense;
  DateTime _choosenDate = DateTime.now();

  void _onSubmitData() {
    if (_descriptionTextConroller.text.isEmpty || _amountConroller.text.isEmpty) return;
    final description = _descriptionTextConroller.text;
    final amount = double.parse(_amountConroller.text);
    if (description.isEmpty || amount <= 0) {
      return;
    }
    final newTx = MyTransaction(
      description: description,
      amount: amount,
      createdAt: _choosenDate,
      category: _transactionCategory,
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
      heightFactor: 0.95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            const Text('Add Expense', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
              controller: _amountConroller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            // const SizedBox(height: 12),
            // TextField(
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: 'Description',
            //   ),
            //   controller: _descriptionTextConroller,
            //   /* onSubmitted: (_) => _onSubmitData(), */
            // ),
            const SizedBox(height: 10),
            datePickerView(context),
            transactionCategoryPickerView(context),
            const SizedBox(height: 10),
            OptionSwitch<MyTransactionDataType>(
              value: _transactionType,
              onSelect: (newValue) => setState(() => _transactionType = newValue),
              optionNames: const [Text('Expense'), Text('Income')],
              options: const [MyTransactionDataType.expense, MyTransactionDataType.income],
            ),
            const SizedBox(height: 28),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Center submitButton() {
    return Center(
      child: SizedBox(
        width: 240,
        height: 50,
        child: ElevatedButton(
          onPressed: _onSubmitData,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            elevation: 1,
          ),
          child: const Text('Add transaction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }

  Row datePickerView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.date_range, size: 28),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            DateFormat.yMEd().format(_choosenDate),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        TextButton(onPressed: _onShowDatePicker, child: const Text('Change Date'))
      ],
    );
  }

  Row transactionCategoryPickerView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.credit_card, size: 28),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            _transactionCategory?.name ?? 'Category',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        DropdownButton<TransactionCategory>(
          underline: const SizedBox(),
          icon: Text(
            'Select Category',
            style: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).primaryColor),
          ),
          items: transactionCategories
              .map((category) => DropdownMenuItem<TransactionCategory>(
                    value: category,
                    child: Text(category.name),
                  ))
              .toList(),
          onChanged: (selectedCategory) {
            setState(() {
              _transactionCategory = selectedCategory;
            });
          },
        )
      ],
    );
  }
}
