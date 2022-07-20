import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum MyTransactionDataType { expanse, income }

class MyTransaction {
  String id;
  String title;
  double amount;
  DateTime createdAt;
  MyTransactionDataType type;

  MyTransaction({
    this.id = '',
    required this.title,
    required this.amount,
    required this.createdAt,
    this.type = MyTransactionDataType.income,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'createdAt': createdAt,
      'type': type.name,
    };
  }

  static MyTransaction fromJson(Map<String, dynamic> json) {
    return MyTransaction(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      type: MyTransactionDataType.values.firstWhere((e) => describeEnum(e) == json['type']),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
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
