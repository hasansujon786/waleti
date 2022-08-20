import 'models.dart';

class CatetoryItemData {
  CatetoryItemData({
    this.items = const <MyTransaction>[],
    required this.category,
    this.total = 0,
  });
  final TransactionCategory category;
  final List<MyTransaction> items;
  final double total;
}
