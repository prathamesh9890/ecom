import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        title: Image.asset('assets/logo.png', height: 40), // Your logo
        actions: [
          Icon(Icons.shopping_cart, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            _bannerSection(),
            _shopByBrands(),
            _browseCategory(),
            _shopByCategory(),
            _mensAndWomensCollection(),
            _flashSale(),
            _faqSection(),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _bannerSection() {
    return Container(
      height: 200,
      child: PageView(
        children: [
          Image.asset('assets/banner1.jpg', fit: BoxFit.cover),
          Image.asset('assets/banner2.jpg', fit: BoxFit.cover),
        ],
      ),
    );
  }

  Widget _shopByBrands() {
    return Column(
      children: [
        Text("Shop By Brands", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
          ),
          itemCount: 6, // Total brands
          itemBuilder: (context, index) {
            return Card(
              child: Center(child: Text("Brand ${index + 1}")),
            );
          },
        ),
      ],
    );
  }

  Widget _browseCategory() {
    return Column(
      children: [
        Text("Browse Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _categoryTile("Mens", "assets/mens.jpg"),
        _categoryTile("Women", "assets/women.jpg"),
        _categoryTile("Kids", "assets/kids.jpg"),
      ],
    );
  }

  Widget _categoryTile(String title, String image) {
    return Card(
      child: ListTile(
        leading: Image.asset(image, width: 50),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _shopByCategory() {
    return Column(
      children: [
        Text("Shop By Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Expanded(child: Image.asset('assets/category${index + 1}.jpg', fit: BoxFit.cover)),
                  Text("Category ${index + 1}"),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _mensAndWomensCollection() {
    return Column(
      children: [
        Text("Men's Cloth Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _productList(),
        Text("Women's Cloth Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _productList(),
      ],
    );
  }

  Widget _productList() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.asset('assets/product${index + 1}.jpg', width: 100, height: 100),
                Text("Product ${index + 1}"),
                Text("\$590", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _flashSale() {
    return Column(
      children: [
        Text("Flash Sale", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Image.asset('assets/flashsale.jpg', width: double.infinity, height: 150, fit: BoxFit.cover),
      ],
    );
  }

  Widget _faqSection() {
    return ExpansionTile(
      title: Text("Frequently Asked Questions"),
      children: [
        _faqTile("How can I place an order?"),
        _faqTile("Is COD (Cash on Delivery) available?"),
        _faqTile("What is your cancellation policy?"),
        _faqTile("What is your return policy?"),
      ],
    );
  }

  Widget _faqTile(String question) {
    return ListTile(
      title: Text(question),
      trailing: Icon(Icons.arrow_drop_down),
    );
  }

  Widget _footer() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.red,
      child: Column(
        children: [
          Text("© 2025 KDigitalCurry. All rights reserved.", style: TextStyle(color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Products", style: TextStyle(color: Colors.white)),
              Text("Company", style: TextStyle(color: Colors.white)),
              Text("Shop", style: TextStyle(color: Colors.white)),
              Text("Service", style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
