import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final List<String> categories = ["Men", "Women", "Electronics", "Jewelry"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CategoryScreen(),
  ));
}
