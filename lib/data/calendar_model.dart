import 'package:hive/hive.dart';
part 'calendar_model.g.dart';

@HiveType(typeId: 1)
class CalendarModel {
  @HiveField(0)
  Map<String, List<DayIs>> day = {};
  CalendarModel({required this.day});
}

@HiveType(typeId: 2)
class DayIs {
  @HiveField(0)
  DateTime data;
  @HiveField(1)
  String? start;
  @HiveField(2)
  String? finish;
  @HiveField(3)
  String? payment;
  @HiveField(4)
  String? tip;
  @HiveField(5)
  String note = '';

  DayIs({
    required this.data,
    this.start,
    this.finish,
    this.payment,
    this.tip,
    required this.note,
  });
}
