import 'package:flutter/material.dart';
import 'package:recipes/View/home.dart';
import 'package:recipes/View/viewResources/estilo.dart';

void main() {
  runApp(MaterialApp(
    title: "Agenda",
    home: const Home(),
    debugShowCheckedModeBanner: false,
    theme: estilo(),
  ));
}
