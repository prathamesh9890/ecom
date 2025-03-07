import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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
              backgroundImage: AssetImage('assets/profile.jpg'), // Change this to the actual image
            ),
            SizedBox(height: 10),
            Text(
              'Sipho Nkosi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Edit Profile', style: TextStyle(color: Colors.grey)),
            ),
            Divider(),
            buildProfileOption(Icons.list_alt, 'My Orders'),
            buildProfileOption(Icons.favorite_border, 'My Wishlist'),
            buildProfileOption(Icons.location_on_outlined, 'My Address'),
            buildProfileOption(Icons.contact_support_outlined, 'Contact Us'),
            buildProfileOption(Icons.logout, 'Logout'),
            SizedBox(height: 20),
            Container(
              color: Colors.red,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset('assets/logo.png', height: 40),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildFooterOption('Products'),
                      buildFooterOption('Company'),
                      buildFooterOption('Shop'),
                      buildFooterOption('Service'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('What’s New  |  Sales  |  Top Picks',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  Text(
                    '© 2025 KDigitalCurry. All rights reserved.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
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

  Widget buildFooterOption(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
