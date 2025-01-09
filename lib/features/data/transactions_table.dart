import 'package:drift/drift.dart';

// Definiujemy tabelę
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  TextColumn get description => text().nullable()();
  TextColumn get type => text()();
}
