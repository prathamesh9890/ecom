import 'package:flutter/material.dart';

import 'MenCategoryScreen.dart';
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
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            onTap: () {},
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
                // ✅ "Men" category pe click karne par MenCategoryScreen khul jayega
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenCategoryScreen()),
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

//
// class CategoryScreen extends StatelessWidget {
//   final List<String> categories = ["Men", "Women", "Electronics", "Jewelry"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Categories"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: ListView.separated(
//         padding: EdgeInsets.all(16),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(categories[index]),
//             trailing: Icon(Icons.arrow_forward_ios, size: 16),
//             onTap: () {},
//           );
//         },
//         separatorBuilder: (context, index) => Divider(),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false, // ✅ Debug banner removed
//     home: CategoryScreen(),
//   ));
// }
