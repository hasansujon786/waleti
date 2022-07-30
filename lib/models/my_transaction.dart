import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'my_transaction.g.dart';

enum MyTransactionDataType { expanse, income }

var _uuid = const Uuid();

@HiveType(typeId: 1)
class MyTransaction extends HiveObject {
  MyTransaction({
    required this.title,
    required this.amount,
    DateTime? createdAt,
    String? id,
    MyTransactionDataType type = MyTransactionDataType.expanse,
  })  : createdAt = createdAt ?? DateTime.now(),
        id = id ?? _uuid.v4(),
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
