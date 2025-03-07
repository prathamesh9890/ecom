import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rustic Suede Bomber Jacket',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'A modern shirt with a unique creased texture and a functional front pocket, perfect for effortless style and versatility.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '\$750',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '\$850',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Color',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        ColorOption(color: Colors.brown, label: 'Dark Brown'),
                        ColorOption(color: Colors.blue, label: 'Steel Blue'),
                        ColorOption(color: Colors.black, label: 'Black'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Select Size',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: ['S', 'M', 'L', 'XS', 'XL'].map((size) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(size),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Add to Cart'),
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
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Similar Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    SimilarProduct(
                      name: 'Indigo Edge Denim Jacket',
                      price: '\$620',
                      originalPrice: '\$740',
                    ),
                    SimilarProduct(
                      name: 'Steel Gray Shirt',
                      price: '\$620',
                      originalPrice: '\$740',
                    ),
                    SimilarProduct(
                      name: 'Indigo Edge Denim Jacket',
                      price: '\$620',
                      originalPrice: '\$740',
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ratings & Reviews',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Review(
                      name: 'Amit S.',
                      date: 'October 3, 2024',
                      rating: 5,
                      review:
                      'I love the textured look of this shirt! It adds a unique touch to my outfit, and the pocket is a practical addition. Perfect for casual and semi-formal occasions.',
                    ),
                    Review(
                      name: 'Alex.',
                      date: 'October 3, 2024',
                      rating: 5,
                      review:
                      'I love the textured look of this shirt! It adds a unique touch to my outfit, and the pocket is a practical addition. Perfect for casual and semi-formal occasions.',
                    ),
                    Review(
                      name: 'Rahul M.',
                      date: 'October 3, 2024',
                      rating: 5,
                      review:
                      'The fit is just right, and it works well with both jeans and formal trousers. The creased design is subtle but makes a statement!',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final String label;

  ColorOption({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}

class SimilarProduct extends StatelessWidget {
  final String name;
  final String price;
  final String originalPrice;

  SimilarProduct({
    required this.name,
    required this.price,
    required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Text(
            originalPrice,
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}

class Review extends StatelessWidget {
  final String name;
  final String date;
  final int rating;
  final String review;

  Review({
    required this.name,
    required this.date,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name - $date',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              );
            }),
          ),
          SizedBox(height: 4),
          Text(review),
        ],
      ),
    );
  }
}