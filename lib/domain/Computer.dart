import 'package:intl/intl.dart';

class Computer{
  final String name;
  final DateTime updateDate;
  final Map<String, String> software;
  static final DateFormat dateFormatTemplate = DateFormat("'Updated: 'dd.MM.yyyy 'at' HH:mm:ss");

  Computer({this.name, this.updateDate, this.software});

  String get updateDateF => dateFormatTemplate.format(updateDate);



}
