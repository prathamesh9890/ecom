import 'package:flutter/material.dart';

import 'MenCategoryScreen.dart';
import 'ProductListing.dart';
import 'ProfileScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text("Categories"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.label_important),
            title: Text("Men Fashion List"),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenCat()),
            );},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// 📌 Category Screen
class CategoryScreen extends StatelessWidget {
  final List<String> categories = ["Men", "Women", "Electronics", "Jewelry"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              if (categories[index] == "Men") {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductList()),
                );
              }
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

