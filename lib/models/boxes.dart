import 'package:hive/hive.dart';
import 'package:waleti/models/models.dart';

class Boxes {
  static Box<MyTransaction> transaction() => Hive.box<MyTransaction>('MY_TRANSACTION_BOX');
}
