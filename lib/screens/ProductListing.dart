import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ShoppingScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            _buildBanner(),
            _buildShopByBrands(),
            _buildCategorySection(),
            _buildShopByCategory(),
            _buildMenWomenClothing(),
            _buildFlashSale(),
            _buildFAQSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 200,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/banner.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildShopByBrands() {
    return Column(
      children: [
        Text('Shop By Brands', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        // Add brand logos here
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      children: [
        Text('Browse Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        // Add categories here
      ],
    );
  }

  Widget _buildShopByCategory() {
    return Column(
      children: [
        Text('Shop By Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        // Add shop categories here
      ],
    );
  }

  Widget _buildMenWomenClothing() {
    return Column(
      children: [
        Text("Men's Cloth Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        // Add men's clothing here
        Text("Women's Cloth Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        // Add women's clothing here
      ],
    );
  }

  Widget _buildFlashSale() {
    return Column(
      children: [
        Text('Flash Sale', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        // Add flash sale items here
      ],
    );
  }

  Widget _buildFAQSection() {
    return Column(
      children: [
        Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        // Add FAQ here
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.red,
      child: Center(
        child: Text('© 2025 KDigitalCurry. All rights reserved.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
