import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'FilterScreen.dart';
import 'ProductDetails.dart';

void main() {
  runApp(ProductList());
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListing(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 📌 Product Listing Screen
class ProductListing extends StatefulWidget {
  @override
  _ProductListingState createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Listing')),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
              }, child: Text('Sort By')),
          SizedBox(width: 10,),
          ElevatedButton(onPressed: (){}, child: Text('Filter')),
          ]),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
          
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(product: product),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: product['image'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\$${product['price']}',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
          
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}


class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductDetails({required this.product});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isAddingToCart = false;

  Future<void> addToCart(int productId) async {
    setState(() {
      isAddingToCart = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/carts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": 1, // Hardcoded user ID, replace if needed
          "date": "2024-03-05", // Current date (mocked)
          "products": [
            {"productId": productId, "quantity": 1}
          ]
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added to cart successfully!')),
        );
      } else {
        throw Exception('Failed to add product to cart');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        isAddingToCart = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            CachedNetworkImage(
              imageUrl: widget.product['image'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['title'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.product['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '\$${widget.product['price']}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 16),

                  // ✅ Add to Cart Button with API Integration
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isAddingToCart ? null : () => addToCart(widget.product['id']),
                          child: isAddingToCart
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Add to Cart'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Buy Now'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Add To Wishlist'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// 📌 Product Details Screen with Similar Products
// class ProductDetails extends StatefulWidget {
//   final Map<String, dynamic> product;
//
//   ProductDetails({required this.product});
//
//   @override
//   _ProductDetailsState createState() => _ProductDetailsState();
// }
//
// class _ProductDetailsState extends State<ProductDetails> {
//   List<dynamic> similarProducts = [];
//   bool isLoadingSimilar = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSimilarProducts();
//   }
//
//   Future<void> fetchSimilarProducts() async {
//     String category = widget.product['category'];
//     final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/$category'));
//
//     if (response.statusCode == 200) {
//       List<dynamic> products = json.decode(response.body);
//
//       // 🔥 Current product ko remove karna similar products list se
//       products.removeWhere((item) => item['id'] == widget.product['id']);
//
//       setState(() {
//         similarProducts = products;
//         isLoadingSimilar = false;
//       });
//     } else {
//       throw Exception('Failed to load similar products');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Product Details')),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             CachedNetworkImage(
//               imageUrl: widget.product['image'],
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: 300,
//               placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product Title
//                   Text(
//                     widget.product['title'],
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//
//                   // Product Description
//                   Text(
//                     widget.product['description'],
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 16),
//
//                   // Price
//                   Text(
//                     '\$${widget.product['price']}',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//
//                   // Add to Cart and Buy Now Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//
//                           },
//                           child: Text('Add to Cart'),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           child: Text('Buy Now'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text('Add To Wishlist'),
//                   ),
//
//                   SizedBox(height: 16),
//                   Divider(),
//
//                   // 🔥 Similar Products Section
//                   Text(
//                     'Similar Products',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   isLoadingSimilar
//                       ? Center(child: CircularProgressIndicator())
//                       : Column(
//                     children: similarProducts.map((product) {
//                       return ListTile(
//                         leading: CachedNetworkImage(
//                           imageUrl: product['image'],
//                           width: 50,
//                           height: 50,
//                           placeholder: (context, url) => CircularProgressIndicator(),
//                           errorWidget: (context, url, error) => Icon(Icons.error),
//                         ),
//                         title: Text(product['title'], maxLines: 1, overflow: TextOverflow.ellipsis),
//                         subtitle: Text('\$${product['price']}'),
//                         onTap: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductDetails(product: product),
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Ratings & Reviews',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Review(
//                           name: 'Amit S.',
//                           date: 'October 3, 2024',
//                           rating: 5,
//                           review:
//                           'I love the textured look of this shirt! It adds a unique touch to my outfit, and the pocket is a practical addition. Perfect for casual and semi-formal occasions.',
//                         ),
//                         Review(
//                           name: 'Alex.',
//                           date: 'October 3, 2024',
//                           rating: 5,
//                           review:
//                           'I love the textured look of this shirt! It adds a unique touch to my outfit, and the pocket is a practical addition. Perfect for casual and semi-formal occasions.',
//                         ),
//                         Review(
//                           name: 'Rahul M.',
//                           date: 'October 3, 2024',
//                           rating: 5,
//                           review:
//                           'The fit is just right, and it works well with both jeans and formal trousers. The creased design is subtle but makes a statement!',
//                         ),
//                       ],
//                     ),
//                   ),
//               Container(
//                 color: Colors.red,
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Image.asset('assets/images/img.png', height: 60),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         TextButton(onPressed: () {}, child: Text('Products', style: TextStyle(color: Colors.white))),
//                         TextButton(onPressed: () {}, child: Text('Company', style: TextStyle(color: Colors.white))),
//                         TextButton(onPressed: () {}, child: Text('Shop', style: TextStyle(color: Colors.white))),
//                         TextButton(onPressed: () {}, child: Text('Service', style: TextStyle(color: Colors.white))),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 30), //
//                       child: Text(
//                         'What’s New\nSales\nTop Picks',
//                         style: TextStyle(color: Colors.white),
//                         textAlign: TextAlign.left, // Ensure left alignment
//                       ),
//
//                     ),
//                     SizedBox(height: 40),
//                     Center(
//                       child: Text(
//                         '© 2025 KDigitalCurry. All rights reserved.',
//                         style: TextStyle(color: Colors.white70, fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
