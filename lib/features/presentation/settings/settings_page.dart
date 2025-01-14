import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/config_provider.dart';

class SettingsPage extends StatefulWidget {
  final Function switchPage;

  const SettingsPage({super.key, required this.switchPage});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  String? _selectedColor = "Niebieski";
  bool systemTheme = true;
  bool darkTheme = true;
  Map<String, Color> colorList = {
    'Niebieski': Colors.blue,
    'Czerwony': Colors.red,
    'Zielony': Colors.green,
  };

  Future<File> _getConfigFile() async {
    final path = await getFilePath();
    return File(path);
  }

  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/config.json';
  }



  void submit(){
    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    configProvider.updateUsername(_usernameController.text);
    configProvider.updateTheme(darkTheme: darkTheme, systemTheme: systemTheme);
    configProvider.updateSelectedColor(_selectedColor!);
    widget.switchPage(0);
  }

  @override
  void initState() {
    super.initState();
    final config = Provider.of<ConfigProvider>(context, listen: false);
    _usernameController.text = config.username;
    _selectedColor = config.selectedColor;
    systemTheme = config.systemTheme;
    darkTheme = config.darkTheme;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
            child: Container(
              width: double.infinity,
              child: Text(
                "Informacje użytkownika:",
                textAlign: TextAlign.left,
                style: style.copyWith(fontSize: 30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0).copyWith(top: 5, bottom: 5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 65,
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Nazwa użytkownika',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nazwa użytkownika nie może być pusta';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
            child: Container(
              width: double.infinity,
              child: Text(
                "Wygląd:",
                textAlign: TextAlign.left,
                style: style.copyWith(fontSize: 30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0).copyWith(top: 5, bottom: 5),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tryb ciemny:",
                          style: style.copyWith(fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Card(
                      color: theme.colorScheme.onSecondary,
                      child: Column(
                        children: [
                          CheckboxListTile(
                            title: Text("Motyw systemowy"),
                            value: systemTheme,
                            onChanged: (bool? value) {
                              setState(() {
                                systemTheme = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            enabled: !systemTheme,
                            title: Text("Tryb ciemny"),
                            value: darkTheme,
                            onChanged: (bool? value) {
                              setState(() {
                                darkTheme = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kolor motywu:",
                          style: style.copyWith(fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Card(
                      color: theme.colorScheme.onSecondary,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16).copyWith(top: 0),
                            child: DropdownButtonFormField<String>(
                              value: _selectedColor,
                              items: ["Niebieski", "Czerwony", "Zielony"]
                                  .map((category) => DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: [
                                    Icon(Icons.circle,
                                        color: colorList[category]),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(category),
                                  ],
                                ),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedColor = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                onPressed:() => submit(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Zatwierdź",
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
    );
  }
}
