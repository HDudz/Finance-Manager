import 'package:drift/drift.dart';




class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  TextColumn get description => text().nullable()();
  TextColumn get category => text().nullable()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get type => text()();
}
