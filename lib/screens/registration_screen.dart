import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';
import 'login_screen.dart';

void main() {
  runApp(Registration_screen());
}

class Registration_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  // ✅ Email Validation Function
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // ✅ Input Validation Function
  bool validateInputs() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        addressController.text.isEmpty) {
      setState(() {
        errorMessage = 'All fields are required!';
      });
      return false;
    }

    if (!isValidEmail(emailController.text)) {
      setState(() {
        errorMessage = 'Invalid email format!';
      });
      return false;
    }

    if (passwordController.text.length < 6) {
      setState(() {
        errorMessage = 'Password must be at least 6 characters!';
      });
      return false;
    }

    setState(() {
      errorMessage = '';
    });

    return true;
  }

  Future<void> signup() async {
    if (!validateInputs()) return; // ✅ Validation Check

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final url = Uri.parse('https://fakestoreapi.com/users');

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "id": 0,
          "username": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
         // "address": {"city": addressController.text},
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        final responseData = jsonDecode(response.body);
        String userId = responseData['id'].toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', userId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration Successfully!"),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login_Screen()),
        );
        // setState(() {
        //   isLoading = false;
        // });
      } else {
        setState(() {
          errorMessage = 'Signup failed. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 200,
              width: double.infinity,
              child: Center(
                child: Image.asset(
                  'assets/images/img.png',
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      children: [
                        Icon(Icons.error, color: Colors.white, size: 50),
                        Text(
                          'Image not found!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create an Account',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  buildTextField('Username', 'Enter your username', usernameController),
                  buildTextField('Email', 'Enter your email', emailController),
                  buildTextField('Address', 'Enter your address', addressController),
                  buildTextField('Password', 'Enter your password', passwordController, isPassword: true),

                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(errorMessage, style: TextStyle(color: Colors.red)),
                    ),

                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: isLoading ? null : signup,
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login_Screen()),
                        );
                      },
                      child: Text('Already have an Account? Login', style: TextStyle(color: Colors.red, fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label*', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: isPassword ? Icon(Icons.visibility) : null,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
