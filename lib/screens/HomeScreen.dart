import 'package:flutter/material.dart';
import 'CategoryScreen.dart';
import 'ProductListing.dart';
import 'ProfileScreen.dart';

void main() {
  runApp(Home_Screen());
}

class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // automaticallyImplyLeading: true,
        // leading: Icon(Icons.menu, color: Colors.black),
        // title: Image.asset('assets/images/img.png', color: Colors.red, height: 40),
        // centerTitle: true, // Your logo
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.list_alt, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductList()),
              );
            },
          ),
          SizedBox(width: 10),
        ],

      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            _bannerSection(),
            _shopByBrands(),
            _browseCategory(),
            _shopByCategory(), // Updated Section
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
      height: 300,
      child: PageView(
        children: [
          Image.asset('assets/images/home.png', fit: BoxFit.cover),
          Image.asset('assets/images/fashion.png', fit: BoxFit.cover),
          Image.asset('assets/images/fashion1.png', fit: BoxFit.cover),
          Image.asset('assets/images/sales.png', fit: BoxFit.cover),

        ],
      ),
    );
  }

  Widget _shopByBrands() {
    List<Map<String, String>> brands = [
      {
        "name": "Nike",
        "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Logo_NIKE.svg/1200px-Logo_NIKE.svg.png"
      },
      {
        "name": "Adidas",
        "image": "https://upload.wikimedia.org/wikipedia/commons/2/24/Adidas_logo.png"
      },
      {
        "name": "Puma",
        "image": "https://kreafolk.com/cdn/shop/articles/puma-logo-design-history-and-evolution-kreafolk_a042e2da-4ee1-4b78-a7be-c7c2e6acf65a.jpg?v=1717725066&width=2048"
      },
      {
        "name": "Reebok",
        "image": "https://logos-world.net/wp-content/uploads/2020/04/Reebok-Logo.png"
      },
      {
        "name": "Samsung",
        "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Samsung_Logo.svg/1200px-Samsung_Logo.svg.png"
      },
      {
        "name": "Apple",
        "image": "https://banner2.cleanpng.com/20180625/pgg/aaz8nox3y.webp"
      },
    ];

    return Column(
      children: [
        Text("Shop By Brands", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 brands ek row me
            childAspectRatio: 1, // Square grid items
          ),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.network(
                      brands[index]["image"]!,
                      fit: BoxFit.contain,
                      width: 80, // Logo ka size adjust karne ke liye
                      height: 80,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      brands[index]["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
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
        Image.asset('assets/images/mens.png', fit: BoxFit.cover),
        SizedBox(height: 8),
        Image.asset('assets/images/women.png', fit: BoxFit.cover),
        SizedBox(height: 8),
        Image.asset('assets/images/kids.png', fit: BoxFit.cover),
        SizedBox(height: 8,)
      ],
    );
  }

  Widget _shopByCategory() {
    List<Map<String, String>> categories = [
      {"name": "Men's Clothing", "image": "assets/images/mensClothing.png"},
      {"name": "Women's Clothing", "image": "assets/images/womenClothing.png"},
      {"name": "Electronics", "image": "assets/images/electonic.png"},
      {"name": "Jewelry", "image": "assets/images/jewelry.png"},
      {"name": "Shoes", "image": "assets/images/shoes.png"},
      {"name": "Watches", "image": "assets/images/watches.png"},
    ];

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
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(categories[index]["image"]!, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categories[index]["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
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
        _productList(isMensCollection: true), // Men's Collection
        Text("Women's Cloth Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _productList(isMensCollection: false), // Women's Collection
      ],
    );
  }

  Widget _productList({required bool isMensCollection}) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.asset(
                  isMensCollection
                      ? 'assets/images/mensCloth.png'  // Men's Clothing Image
                      : 'assets/images/womenCloths.png', // Women's Clothing Image
                  width: 100,
                  height: 100,
                ),
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
    List<String> flashSaleImages = [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHH4Ikx-cPI9TAep03DoHiydisrYMH33HIGA&s",
      "https://img.freepik.com/free-vector/flat-design-second-hand-template_23-2150537710.jpg?semt=ais_hybrid",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9QgrCNo9NpfPVVsYNriVC7Pl9Z0AENkQ_mQ&s",
      "https://www.shutterstock.com/image-photo/young-woman-chooses-which-outfit-260nw-2300456923.jpg"
    ];

    return Column(
      children: [
        Text("Flash Sale", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 150,
          child: PageView.builder(
            itemCount: flashSaleImages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: Image.network(
                    flashSaleImages[index],
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 50),
                  ),
                ),
              );
            },
          ),
        ),
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
    return  Container(
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
              TextButton(onPressed: () {}, child: Text('Products', style: TextStyle(color: Colors.white))),
              TextButton(onPressed: () {}, child: Text('Company', style: TextStyle(color: Colors.white))),
              TextButton(onPressed: () {}, child: Text('Shop', style: TextStyle(color: Colors.white))),
              TextButton(onPressed: () {}, child: Text('Service', style: TextStyle(color: Colors.white))),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 30), //
            child: Text(
              'What’s New\nSales\nTop Picks',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left, // Ensure left alignment
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
    );
  }
  // Widget buildFooterOption(String title) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //     child: Text(title, style: TextStyle(color: Colors.white)),
  //   );
  // }
}
