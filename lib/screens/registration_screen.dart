import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}

class SignupScreen extends StatelessWidget {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 80),
                  SizedBox(height: 10),
                  Text(
                    'KDigitalCurry',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create a Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  buildTextField('Full Name', 'Enter your Full Name'),
                  buildTextField('Phone Number', 'Enter Phone Number', prefix: '+27'),
                  buildTextField('Email', 'Enter Your Email'),
                  buildTextField('Address', 'Enter Address'),
                  buildTextField('User Name', 'Enter User Name'),
                  buildTextField('Password', 'Enter Password', isPassword: true),
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
                      onPressed: () {},
                      child: Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Already have an Account? Login',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
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

  Widget buildTextField(String label, String hint, {bool isPassword = false, String? prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label*', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
            prefixStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () {},
            )
                : null,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
