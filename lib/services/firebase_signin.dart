import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/login_screen.dart';
import 'package:recipe_app/views/home.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  // create a global key for the form
  final _formKey = GlobalKey<FormState>();
  // create a text editing controller for the email input
  final _emailController = TextEditingController();
  // create a text editing controller for the password input
  final _passwordController = TextEditingController();
  // create a controller for username
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // add padding around the Form widget
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.squarespace-cdn.com/content/v1/562d08fee4b072888c2d4110/1538001622543-EI6C4BZ1ZBD2047ZFFYV/katherine-chase-518230-unsplash.jpg?format=1500w',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                  key: _formKey,
                                ),
                              )),
                          child: const Text(
                            "Sign In!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0 * 2),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              hintText: "username",
                              labelText: "Username",
                            ),
                            validator: (username) {
                              if (username == null || username.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          // email text field
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: "Your email",
                              labelText: "Email",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          // password field
                          TextFormField(
                            // We want to hide our password
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "******",
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password should be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0 * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Sign up form is done
                            // It saved our inputs
                            _registerUser();
                            _formKey.currentState!.save();
                            _nameController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                          }
                        },
                        child: const Text("Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // register user method
  Future<void> _registerUser() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      print("User registered: ${userCredential.user!.uid}");
      // Navigate to HomePage after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print("Error registering user: ${e.code}");
    } catch (e) {
      print("Error registering user: $e");
    }
  }
}
