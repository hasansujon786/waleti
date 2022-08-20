import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'transaction_category.dart';

part 'my_transaction.g.dart';

enum MyTransactionDataType { expanse, income }

var _uuid = const Uuid();

@HiveType(typeId: 1)
class MyTransaction extends HiveObject {
  MyTransaction({
    required this.title,
    required this.amount,
    TransactionCategory? category,
    DateTime? createdAt,
    String? id,
    MyTransactionDataType type = MyTransactionDataType.expanse,
  })  : createdAt = createdAt ?? DateTime.now(),
        id = id ?? _uuid.v4(),
        _category = category?.name,
        _type = type.name;

  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double amount;
  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  String _type;
  set type(MyTransactionDataType value) => _type = value.name;
  MyTransactionDataType get type => _type == 'expanse' ? MyTransactionDataType.expanse : MyTransactionDataType.income;

  @HiveField(5)
  String? _category;
  set category(TransactionCategory? ct) => _category = ct?.name;
  TransactionCategory get category {
    if (_category == null) {
      final defaultIcon = type == MyTransactionDataType.expanse ? Icons.trending_down : Icons.trending_up;
      return TransactionCategory('Not listed', defaultIcon);
    }
    return transactionCategories.firstWhere((cg) => cg.name == _category);
  }

  factory MyTransaction.fromJson(Map<String, dynamic> json) {
    return MyTransaction(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      type: MyTransactionDataType.values.firstWhere((e) => describeEnum(e) == json['type']),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  factory MyTransaction.empty() => MyTransaction(title: '', amount: 0);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'createdAt': createdAt,
      'type': type.name,
    };
  }
}

final List<MyTransaction> demoTransactions = [
  MyTransaction(
    id: 't1',
    title: 'Title text',
    type: MyTransactionDataType.expanse,
    amount: 70.0,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  MyTransaction(
    id: 't2',
    title: 'Weekly Groceries',
    amount: 50.0,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  MyTransaction(
    id: 't1',
    title: 'Untitled',
    amount: 70.0,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
