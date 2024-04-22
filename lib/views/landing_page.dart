import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_shopping_cart_app/views/checkout_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  List<int> quantities = List<int>.generate(products.length, (index) => 0);
  List<Product> cartItems = [];

  int totalCartItems = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Handle profile button click
            },
          ),
          Stack(
            children: [
              PopupMenuButton<Product>(
                icon: const Icon(Icons.shopping_cart),
                onSelected: (value) {
                  // Handle selection of a product title
                },
                itemBuilder: (BuildContext context) {
                  var groupedProducts = groupBy<Product, String>(
                      cartItems, (product) => product.title);
                  var items = groupedProducts.entries
                      .map<PopupMenuEntry<Product>>((entry) {
                    return PopupMenuItem<Product>(
                      value: entry.value[0],
                      child: Text('${entry.key} (${entry.value.length})'),
                    );
                  }).toList();

                  items.add(
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckoutPage()),
                          );
                        },
                        child: const Text('Proceed to Checkout'),
                      ),
                    ),
                  );

                  return items;
                },
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '$totalCartItems',
                    style: const TextStyle(
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
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0), // Add this line
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(product.description),
                    const SizedBox(height: 8),
                    Text('\$${product.price.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantities[index] > 0) {
                            quantities[index]--;
                          }
                        });
                      },
                    ),
                    Text('${quantities[index]}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantities[index]++;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          totalCartItems += quantities[index];
                          for (int i = 0; i < quantities[index]; i++) {
                            cartItems.add(product);
                          }
                          quantities[index] = 0;
                        });
                      },
                      child: const Text('Add to Cart'),
                    ),
                  ],
                ),
                const SizedBox(width: 16), // Add space between products
              ],
            );
          },
        ),
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
  Product(
    title: 'Product 3',
    description: 'Description of Product 1',
    price: 9.99,
  ),
  Product(
    title: 'Product 4',
    description: 'Description of Product 2',
    price: 19.99,
  ),
  Product(
    title: 'Product 5',
    description: 'Description of Product 1',
    price: 9.99,
  ),
  Product(
    title: 'Product 6',
    description: 'Description of Product 2',
    price: 19.99,
  ),
  // Add more products here
];
