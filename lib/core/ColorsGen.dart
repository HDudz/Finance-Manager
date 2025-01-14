import 'dart:math';

import 'package:flutter/material.dart';

var colorList = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.deepPurple,
  Colors.green,
  Colors.orangeAccent,
  Colors.teal,
  Colors.lightGreenAccent.shade700,
  Colors.pink
];

Map<String, Color> colorMap = {
  'Niebieski': Colors.blue,
  'Czerwony': Colors.red,
  'Zielony': Colors.green,
};

var colorSeed = Random().nextInt(10);


Color getColor(list, item)
{
  return colorList[(list.indexOf(item)+colorSeed)%colorList.length];
}



