import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int selectedIndex = 0;
  List<String> filterCategories = [
    "Price",
    "Category",
    "Brands",
    "Colors",
    "Size & Fit",
  ];

  Map<String, bool> priceFilters = {
    "Below \$500": false,
    "Above \$500": false,
    "Above \$1000": false,
  };

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
      body: Row(
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
                        onPressed: () {},
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FilterScreen(),
  ));
}
