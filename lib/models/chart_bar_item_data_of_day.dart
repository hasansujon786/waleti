class ChartBarItemDataOfDay {
  final int day;
  final String dayName;
  final double totalSpendingOfDay;
  final double spendignPercentace;
  final bool isToday;
  const ChartBarItemDataOfDay({
    required this.day,
    required this.dayName,
    required this.totalSpendingOfDay,
    required this.spendignPercentace,
    this.isToday = false,
  });
}
