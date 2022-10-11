import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'goal.g.dart';

var _uuid = const Uuid();

@HiveType(typeId: 2)
class Goal extends HiveObject {
  Goal({
    required this.title,
    required this.targetAmout,
    this.savedAmount = 0,
    DateTime? createdAt,
    String? id,
  })  : createdAt = createdAt ?? DateTime.now(),
        id = id ?? _uuid.v4();

  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime createdAt;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final double targetAmout;
  @HiveField(4)
  double savedAmount;
}
