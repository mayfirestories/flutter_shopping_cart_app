import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
          key: Key('myHomePage'), title: 'Shopping Cart App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> _items = <String>[];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _items = prefs.getStringList('items') ?? [];
    });
  }

  void _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items', _items);
  }

  Future<void> _editItem(int index) async {
    TextEditingController textFieldController =
        TextEditingController(text: _items[index]);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit item'),
          content: Form(
            child: TextField(
              controller: textFieldController,
              decoration: const InputDecoration(hintText: "Item name"),
              onSubmitted: (value) {
                setState(() {
                  _items[index] = value;
                  _saveItems();
                });
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _items[index] = textFieldController.text;
                  _saveItems();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(), // Set LandingPage as the home page
    );
  }
}
