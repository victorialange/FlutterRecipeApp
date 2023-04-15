import 'package:flutter/material.dart';
// import services package to set preferred device orientation
import 'package:flutter/services.dart';
// import home.dart to use it as the home screen for MyApp root widget
import 'package:recipe_app/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tastefully Green',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      // use HomePage widget from separate file from views folder as home screen
      home: const HomeScreen(),
    );
  }
}
