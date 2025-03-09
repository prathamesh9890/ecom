import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://fakestoreapi.com/carts';

  /// ✅ Get Cart Data
  Future<Map<String, dynamic>> fetchCart() async {
    final response = await http.get(Uri.parse('$baseUrl/1'));
    return jsonDecode(response.body);
  }

  /// ✅ Add to Cart
  Future<void> addToCart(int userId, List<Map<String, dynamic>> products) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "date": "2023-10-10",
        "products": products,
      }),
    );
  }

  /// ✅ Update Cart Item
  Future<void> updateCart(int cartId, List<Map<String, dynamic>> products) async {
    await http.put(
      Uri.parse('$baseUrl/$cartId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"products": products}),
    );
  }

  /// ✅ Delete Cart Item
  Future<void> deleteCartItem(int cartId) async {
    await http.delete(Uri.parse('$baseUrl/$cartId'));
  }
}
