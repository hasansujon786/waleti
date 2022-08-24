class ChartBarItemDataOfDay {
  final bool isToday;
  final double width;
  final DateTime dateTime;
  final double totalSpendingOfDay;
  final double spendignPercentace;
  const ChartBarItemDataOfDay({
    this.isToday = false,
    required this.width,
    required this.dateTime,
    required this.totalSpendingOfDay,
    required this.spendignPercentace,
  });
}
