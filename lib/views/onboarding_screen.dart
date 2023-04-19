import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/login_screen.dart';
import 'package:recipe_app/services/firebase_signin.dart';
import 'package:recipe_app/services/initiate_firebase_auth.dart';
import 'package:recipe_app/views/home.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://images.pexels.com/photos/5946083/pexels-photo-5946083.jpeg?auto=compress&cs=tinysrgb&w=600',
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  "Tastefully Green",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff0B9A61)),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationForm(),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF6CD8D1)),
                    child: const Text("Sign Up"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          )),
                      style: TextButton.styleFrom(
                        // backgroundColor: Color(0xFF6CD8D1),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF6CD8D1)),
                        ),
                      ),
                      child: const Text("Sign In"),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
