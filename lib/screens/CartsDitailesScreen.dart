import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() {
//   runApp(MaterialApp(
//     home: CartScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> cartItems = [];
  bool isLoading = true;
  double totalPrice = 0.0;
  double discount = 0.0;
  double couponDiscount = 0.0;

  String selectedCoupon = "";

  // Predefined Coupons
  final List<Map<String, dynamic>> coupons = [
    {"code": "SHIRT20", "discount": 0.20, "description": "Get 20% off on your favorite shirts!"},
    {"code": "BUYSHIRT10", "discount": 10.0, "description": "Save \$10 on your shirt purchase."},
    {"code": "CLASSYSHIRTS25", "discount": 0.25, "description": "25% off on premium shirts"},
    {"code": "SHIRTFEST15", "discount": 0.15, "description": "Enjoy 15% off this season"}
  ];

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  // Fetch cart data from FakeStore API
  Future<void> fetchCart() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/carts/1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> products = data['products'];

      double total = 0.0;

      for (var item in products) {
        final productResponse = await http.get(Uri.parse('https://fakestoreapi.com/products/${item['productId']}'));
        if (productResponse.statusCode == 200) {
          var product = json.decode(productResponse.body);
          product['quantity'] = item['quantity'];
          cartItems.add(product);
          total += (product['price'] * item['quantity']);
        }
      }

      setState(() {
        cartItems = cartItems;
        totalPrice = total;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load cart');
    }
  }

  // Apply Coupon Code
  void applyCoupon(String code) {
    var coupon = coupons.firstWhere((c) => c['code'] == code, orElse: () => {});
    if (coupon.isNotEmpty) {
      setState(() {
        selectedCoupon = code;
        couponDiscount = coupon['discount'] is double
            ? totalPrice * coupon['discount']
            : coupon['discount'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cart Items
              ...cartItems.map((product) {
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          product['image'],
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product['title'], maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text("Qty: ${product['quantity']} | Size: L"),
                              Text("Price: \$${product['price']}", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("10% Off", style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              cartItems.remove(product);
                              totalPrice -= (product['price'] * product['quantity']);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: 10),

              // Coupon Code Section
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Have a promo code"),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(hintText: "Enter Coupon Code"),
                              onChanged: (value) {
                                setState(() {
                                  selectedCoupon = value;
                                });
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => applyCoupon(selectedCoupon),
                            child: Text("Apply"),
                          ),
                        ],
                      ),

                      // Applicable Coupons
                      ...coupons.map((coupon) {
                        return RadioListTile(
                          title: Text(coupon['code']),
                          subtitle: Text(coupon['description']),
                          value: coupon['code'],
                          groupValue: selectedCoupon,
                          onChanged: (value) {
                            applyCoupon(value as String);
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Order Summary
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Total Summary", style: TextStyle(fontWeight: FontWeight.bold)),
                      Divider(),
                      Text("MRP: \$${totalPrice.toStringAsFixed(2)}"),
                      Text("Discount: -\$${(totalPrice * 0.10).toStringAsFixed(2)}"),
                      Text("Coupon Code: -\$${couponDiscount.toStringAsFixed(2)}"),
                      Text("Delivery Fee: \$0"),
                      Divider(),
                      Text("Order Total: \$${(totalPrice - (totalPrice * 0.10) - couponDiscount).toStringAsFixed(2)}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Proceed to Shipping Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Proceeding to Shipping...")),
                    );
                  },
                  child: Text("Proceed to Shipping", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
