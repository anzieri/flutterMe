import 'package:flutter/material.dart';
import 'package:loadbalancer/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   backgroundColor: Colors.white,
      // ),
      //backgroundColor: Colors.white,
      
      home: EndUser(),
    );
  }
}