import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';
import 'login_screen.dart'; // Make sure this file is correctly imported

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating loading time

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token'); // Fetch token from SharedPreferences

    if (token != null) {
      // User is logged in, go to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_Screen()),
      );
    } else {
      // User is not logged in, go to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login_Screen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Adjust the color as per your theme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/img.png', height: 100), // Logo
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
