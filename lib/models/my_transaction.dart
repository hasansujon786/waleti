import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'transaction_category.dart';

part 'my_transaction.g.dart';

enum MyTransactionDataType { expense, income }

var _uuid = const Uuid();

@HiveType(typeId: 1)
class MyTransaction extends HiveObject {
  MyTransaction({
    required this.amount,
    this.description,
    TransactionCategory? category,
    DateTime? createdAt,
    String? id,
    MyTransactionDataType type = MyTransactionDataType.expense,
  })  : createdAt = createdAt ?? DateTime.now(),
        id = id ?? _uuid.v4(),
        _category = category?.name,
        _type = type.name;

  @HiveField(0)
  String id;
  @HiveField(1)
  String? description;
  @HiveField(2)
  double amount;
  @HiveField(3)
  DateTime createdAt;
  @HiveField(4)
  String _type;
  @HiveField(5)
  String? _category;

  // enum MyTransactionDataType
  set type(MyTransactionDataType value) => _type = value.name;
  MyTransactionDataType get type => _type == 'expense' ? MyTransactionDataType.expense : MyTransactionDataType.income;
  bool get isTypeExpense => type == MyTransactionDataType.expense;
  bool get isTypeIncome => type == MyTransactionDataType.income;

  // TransactionCategory
  set category(TransactionCategory? ct) => _category = ct?.name;
  TransactionCategory get category {
    if (_category == null) {
      final defaultIcon = type == MyTransactionDataType.expense ? Icons.trending_down : Icons.trending_up;
      return TransactionCategory('Not listed', defaultIcon);
    }
    return transactionCategories.firstWhere((cg) => cg.name == _category);
  }

  factory MyTransaction.fromJson(Map<String, dynamic> json) {
    return MyTransaction(
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
      type: MyTransactionDataType.values.firstWhere((e) => describeEnum(e) == json['type']),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  factory MyTransaction.empty() => MyTransaction(description: '', amount: 0);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'createdAt': createdAt,
      'type': type.name,
    };
  }
}

final List<MyTransaction> myDemoTransactions = [
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 70.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 20.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 170.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 120.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 40.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 10.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 5.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 90.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 100.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 70.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 70.0,
    createdAt: DateTime.now(),
  ),
  MyTransaction(
    type: MyTransactionDataType.expense,
    amount: 50.0,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  MyTransaction(
    type: MyTransactionDataType.income,
    amount: 70.0,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
