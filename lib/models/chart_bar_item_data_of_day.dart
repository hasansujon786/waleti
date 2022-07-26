class ChartBarItemDataOfDay {
  final bool isToday;
  final DateTime dateTime;
  final double totalSpendingOfDay;
  final double spendignPercentage;
  const ChartBarItemDataOfDay({
    this.isToday = false,
    required this.dateTime,
    required this.totalSpendingOfDay,
    required this.spendignPercentage,
  });

  @override
  String toString() {
    return 'day ${dateTime.day}, totalSpendingOfDay $totalSpendingOfDay, spendignPercentace $spendignPercentage';
  }
}
