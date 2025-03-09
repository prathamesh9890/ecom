import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      home: MenCategoryScreen(),
    );
  }
}

class MenCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Men'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategory('Clothing', ['T-Shirts', 'Shirts', 'Jeans', 'Jacket']),
            _buildCategory('Footwear', ['Sneakers', 'Formal Shoes', 'Sandals']),
            _buildCategory('Accessories', ['Watches', 'Bags', 'Belts', 'Luxury Watches']),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map((item) => Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Text(item, style: TextStyle(fontSize: 14)),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
