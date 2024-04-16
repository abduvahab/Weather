import 'package:flutter/material.dart';
import './myhome.dart';

void main() {
  runApp(const MyApp());
}


class DartPluginRegistrant {
  static void ensureInitialized() {
    // Initialize any necessary Dart plugins here
    // For example:
    // await SomePlugin.initialize();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home:MyHome(),
      // theme: ,
    );
  }
}