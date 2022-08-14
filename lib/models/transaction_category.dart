import 'package:flutter/material.dart';

class TransactionCategory {
  final String name;
  final IconData icon;
  TransactionCategory(this.name, this.icon);
}

final transactionCategories = [
  TransactionCategory('Shopping', Icons.shopping_cart),
  TransactionCategory('Food', Icons.food_bank),
  TransactionCategory('Coffie', Icons.emoji_food_beverage),
];
