import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FilterScreen(),
  ));
}

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int selectedIndex = 0;
  List<String> filterCategories = ["Price", "Category", "Brands"];
  Map<String, bool> priceFilters = {
    "Below \$500": false,
    "Above \$500": false,
    "Above \$1000": false,
  };
  List<String> categories = [];
  String? selectedCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('https://fakestoreapi.com/products/categories');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          categories = List<String>.from(json.decode(response.body));
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  void applyFilter() {
    String baseUrl = "https://fakestoreapi.com/products?";
    List<String> filters = [];

    if (selectedCategory != null) {
      filters.add("category=$selectedCategory");
    }

    if (priceFilters["Below \$500"] == true) {
      filters.add("price_lte=500");
    }
    if (priceFilters["Above \$500"] == true) {
      filters.add("price_gte=500");
    }
    if (priceFilters["Above \$1000"] == true) {
      filters.add("price_gte=1000");
    }

    String finalUrl = filters.isNotEmpty ? "$baseUrl${filters.join("&")}" : baseUrl;
    print("API Call: $finalUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          )
        ],
        elevation: 1,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Row(
        children: [
          // Left side menu
          Container(
            width: 100,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: filterCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    color: selectedIndex == index ? Colors.red : Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Text(
                      filterCategories[index],
                      style: TextStyle(
                        color: selectedIndex == index ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Right side content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedIndex == 0) ...[
                    for (var entry in priceFilters.entries)
                      CheckboxListTile(
                        title: Text(entry.key),
                        value: entry.value,
                        onChanged: (bool? newValue) {
                          setState(() {
                            priceFilters[entry.key] = newValue ?? false;
                          });
                        },
                      ),
                  ],
                  if (selectedIndex == 1) ...[
                    DropdownButton<String>(
                      value: selectedCategory,
                      hint: Text("Select Category"),
                      isExpanded: true,
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                  ],
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                        ),
                        onPressed: () {},
                        child: Text("Cancel", style: TextStyle(color: Colors.black)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: applyFilter,
                        child: Text("Apply Filter"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



