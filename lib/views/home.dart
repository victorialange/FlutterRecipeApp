// this will be the home screen (gets imported into MyApp)
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // center text and icon
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            // add space between icon and text by adding sized box widget
            SizedBox(width: 10),
            Text("Tasty Recipes"),
          ],
        ),
      ),
    );
  }
}
