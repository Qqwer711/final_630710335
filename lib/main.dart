import 'package:final_630710335/service/api.dart';
import 'package:final_630710335/home/pageeee.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '♥♥Final_630710335♥♥',
      theme: ThemeData(

        primarySwatch: Colors.red,


      ),
      home: const HomePage(),
    );
  }
}