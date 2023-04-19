import 'package:flutter/material.dart';
// import services package to set preferred device orientation
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/views/onboarding_screen.dart';
// import home.dart to use it as the home screen for MyApp root widget
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // initialize connection to firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        textTheme: GoogleFonts.notoSansTextTheme(),
      ),
      // use HomePage widget from separate file from views folder as home screen
      home: const OnboardingScreen(),
    );
  }
}
