import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<int> quantities = List<int>.generate(products.length, (index) => 0);
  int totalCartItems = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Handle profile button click
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Handle cart button click
                },
              ),
              if (totalCartItems > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '$totalCartItems',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(
              product.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.description),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text('\$${product.price.toStringAsFixed(2)}'),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantities[index] > 0) {
                                  quantities[index]--;
                                }
                              });
                            },
                          ),
                          Text('${quantities[index]}'), // Replace with actual quantity
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantities[index]++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          totalCartItems += quantities[index];
                          quantities[index] = 0;
                        });
                      },
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final String title;
  final String description;
  final double price;

  Product({
    required this.title,
    required this.description,
    required this.price,
  });
}

final List<Product> products = [
  Product(
    title: 'Product 1',
    description: 'Description of Product 1',
    price: 9.99,
  ),
  Product(
    title: 'Product 2',
    description: 'Description of Product 2',
    price: 19.99,
  ),
  // Add more products here
];