import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/app_database.dart';

class AddTransPage extends StatefulWidget {
  final Function switchPage;

  const AddTransPage({super.key, required this.switchPage});

  @override
  State<AddTransPage> createState() => _AddTransPageState();
}

class _AddTransPageState extends State<AddTransPage> with SingleTickerProviderStateMixin{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory = "Inne";
  String _transactionType = "Wychodzące";
  late TabController _tabController;

  saveToDB(db) async {
    if (_formKey.currentState!.validate()) {
      final transaction = TransactionsCompanion(
        title: drift.Value(_titleController.text),
        amount: drift.Value(double.parse(_amountController.text)),
        description: drift.Value(
          _descriptionController.text.isEmpty
          ? null : _descriptionController.text,
        ),
        category: drift.Value(
          _transactionType == "Wychodzące" ? _selectedCategory : null,
        ),
        date: drift.Value(DateTime.now()),
        type: drift.Value(_transactionType),
      );

      await db.addTransaction(transaction);

      widget.switchPage(1);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {
        _transactionType = _tabController.index  == 0 ? "Wychodzące" : "Przychodzące";
      });
    });
  }


  @override
  void dispose() {
    _tabController.dispose(); // Ważne, aby usunąć kontroler
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
          child: Text("Nowa Transakcja:", style: style),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: "Wychodzące"),
                        Tab(text: "Przychodzące"),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0).copyWith(top:10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 65,
                                child: TextFormField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    hintText: 'Tytuł transakcji',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Podaj tytuł transakcji';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 65,
                                child: TextFormField(
                                  controller: _amountController,
                                  decoration: const InputDecoration(
                                    hintText: 'Kwota',
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Podaj kwotę';
                                    }
                                    final parsedValue = double.tryParse(value);
                                    if (parsedValue == null || parsedValue <= 0) {
                                      return 'Podaj prawidłową kwotę';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 65,
                                child: TextFormField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    hintText: 'Opis (Opcjonalne)',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Column(
                                      children: [
                                        DropdownButtonFormField<String>(
                                          value: _selectedCategory,
                                          items: ["Inne", "Spożywcze", "Rozrywka"]
                                              .map((category) => DropdownMenuItem(
                                            value: category,
                                            child: Text(category),
                                          )).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedCategory = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Container()
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:() => saveToDB(db) ,
                                  style: ButtonStyle(
                                    backgroundColor:
                                    WidgetStateProperty.all(Colors.green.shade800),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      "Dodaj",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
