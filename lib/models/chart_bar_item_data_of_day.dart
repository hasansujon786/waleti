class ChartBarItemDataOfDay {
  final int date;
  final String day;
  final double totalSpendingOfDay;
  final double spendignPercentace;
  final bool isToday;
  const ChartBarItemDataOfDay({
    required this.date,
    required this.day,
    required this.totalSpendingOfDay,
    required this.spendignPercentace,
    this.isToday = false,
  });
}
