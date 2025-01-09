import 'dart:io';

import 'package:drift/drift.dart';

import 'transactions_table.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// Klasa bazy danych
@DriftDatabase(tables: [Transactions])
class AppDatabase extends _$AppDatabase {
  // Lokalizacja pliku bazy danych
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1; // Zwiększaj w przypadku migracji bazy

  // Przykład: Pobierz wszystkie transakcje
  Future<List<Transaction>> getAllTransactions() =>
      select(transactions).get();

  // Przykład: Dodaj transakcję
  Future<int> addTransaction(TransactionsCompanion entry) =>
      into(transactions).insert(entry);

  // Przykład: Usuń transakcję po ID
  Future<int> deleteTransaction(int id) =>
      (delete(transactions)..where((t) => t.id.equals(id))).go();
}

// Funkcja do otwierania bazy danych
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/app_database.sqlite');
    return NativeDatabase(file);
  });
}
