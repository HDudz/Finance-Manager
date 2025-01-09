import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/CategoryDropdown.dart';
import '../../data/app_database.dart';

class AddTransPage extends StatefulWidget{
  final switchPage;

  const AddTransPage({super.key, required this.switchPage});


  @override
  State<AddTransPage> createState() => _AddTransPageState();
}

class _AddTransPageState extends State<AddTransPage> {
  late AppDatabase db;

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
  }
  void switchToAdding(){
  }





  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface,
    );


    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text("Nowa Transakcja:", style: style),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0).copyWith(top: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(

                      children:[
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Tytuł transakcji',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Podaj tytuł transakcji';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Kwota',
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Podaj kwotę';
                                    }
                                    final parsedValue = double.tryParse(value);

                                    if (parsedValue == null) {
                                      return 'Podaj prawidłową kwotę';
                                    }

                                    if(parsedValue == 0){
                                      return 'Kwota nie może być 0';
                                    }
                                    if(parsedValue < 0){
                                      return 'Kwota nie może być mniejsza od 0';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Opis (Opcjonalne)',
                                  ),
                                ),
                              ),
                              DropdownCategory(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Colors.green.shade800),
                              ),
                              onPressed: () => {if (_formKey.currentState!.validate()) {
                                widget.switchPage(0)
                              }},
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Dodaj",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                  fontSize: 18,
                                  ),
                                ),
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
          ),
        ),
      ],
    );
  }
}

