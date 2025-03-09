import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String address = "Nashik, Maharashtra";
  String contact = "+91 7757872473";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Image.asset(
          'assets/images/img.png',
          color: Colors.red,
          height: 50,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            SizedBox(height: 10),
            Text(
              'Prathamesh Rathod',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(address, contact),
                  ),
                );

                if (result != null) {
                  setState(() {
                    address = result['address'];
                    contact = result['contact'];
                  });
                }
              },
              child: Text('Edit Profile', style: TextStyle(color: Colors.grey)),
            ),
            Divider(),
            buildProfileOption(Icons.list_alt, 'My Orders'),
            buildProfileOption(Icons.favorite_border, 'My Wishlist'),

            // ✅ My Address with updated value
            ListTile(
              leading: Icon(Icons.location_on_outlined, color: Colors.black),
              title: Text('My Address'),
              subtitle: Text(address, style: TextStyle(color: Colors.grey)),
              onTap: () {},
            ),

            // ✅ Contact Us with updated value
            ListTile(
              leading: Icon(Icons.contact_support_outlined, color: Colors.black),
              title: Text('Contact Us'),
              subtitle: Text(contact, style: TextStyle(color: Colors.grey)),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('Logout'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // ✅ Shared Preference se logout

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login_Screen()),
                );
              },
            ),

            SizedBox(height: 20),
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset('assets/images/img.png', height: 60),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('Products', style: TextStyle(color: Colors.white))),
                      TextButton(
                          onPressed: () {},
                          child: Text('Company', style: TextStyle(color: Colors.white))),
                      TextButton(
                          onPressed: () {},
                          child: Text('Shop', style: TextStyle(color: Colors.white))),
                      TextButton(
                          onPressed: () {},
                          child: Text('Service', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'What’s New\nSales\nTop Picks',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      '© 2025 KDigitalCurry. All rights reserved.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      onTap: () {},
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final String currentAddress;
  final String currentContact;

  EditProfileScreen(this.currentAddress, this.currentContact);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressController.text = widget.currentAddress;
    contactController.text = widget.currentContact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'address': addressController.text,
                  'contact': contactController.text,
                });
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}