import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> options = <String>["Inne", "Spożywcze", "Rozrywka"];

class DropdownCategory extends StatefulWidget {
  const DropdownCategory({
    super.key,
  });

  @override
  State<DropdownCategory> createState() => _DropdownCategoryState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownCategoryState extends State<DropdownCategory> {
  static final List<MenuEntry> menuEntries = options.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)).toList();


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Oblicz szerokość jako szerokość rodzica - margines
        final dropdownWidth = constraints.maxWidth; // np. 16 pikseli marginesu

        return DropdownMenu<String>(
          width: dropdownWidth > 0 ? dropdownWidth : null, // Dynamicznie obliczona szerokość
          dropdownMenuEntries: menuEntries,
          label: const Text("Wybierz Kategorie"),

        );
      },
    );
  }
}
