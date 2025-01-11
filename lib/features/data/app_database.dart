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

// Metoda do pobierania wszystkich transakcji
  Future<List<Transaction>> getAllTransactions() {
    return select(transactions).get();
  }

  Future<double> getBalance() async {
    final transactionList = await select(transactions).get();

    // Oblicz bilans
    double balance = 0.0;
    for (final transaction in transactionList) {
      if (transaction.type == "Przychodzące") {
        balance += transaction.amount;
      } else if (transaction.type == "Wychodzące") {
        balance -= transaction.amount;
      }
    }

    return balance;
  }

  // Metoda do dodawania nowej transakcji
  Future<int> addTransaction(TransactionsCompanion transaction) {
    return into(transactions).insert(transaction);
  }



}

// Funkcja do otwierania bazy danych
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/app_database.sqlite');


    return NativeDatabase(file);
  });
}
