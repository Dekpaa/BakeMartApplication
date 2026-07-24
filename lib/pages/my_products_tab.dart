import 'package:flutter/material.dart';

class MyProductsTab extends StatefulWidget {
  const MyProductsTab({super.key});

  @override
  State<MyProductsTab> createState() => _MyProductsTabState();
}

class _MyProductsTabState extends State<MyProductsTab> {
  List<Map<String, dynamic>> products = [
    {'name': 'Premium Flour', 'price': 'RM5.00', 'stock': 120},
    {'name': 'Cocoa Powder', 'price': 'RM8.50', 'stock': 50},
    {'name': 'Vanilla Extract', 'price': 'RM12.00', 'stock': 30},
  ];

  void _showProductForm({int? index}) async {
    final isEditing = index != null;
    final product = isEditing ? products[index] : {};

    final nameController = TextEditingController(text: product['name'] ?? '');
    final priceController = TextEditingController(text: product['price'] ?? '');
    final stockController = TextEditingController(
      text: product['stock'] != null ? product['stock'].toString() : '',
    );

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(isEditing ? 'Edit Product' : 'Add Product'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                  ),
                  TextField(
                    controller: stockController,
                    decoration: InputDecoration(labelText: 'Stock'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBC02D),
                ),
                onPressed: () {
                  final newProduct = {
                    'name': nameController.text.trim(),
                    'price': priceController.text.trim(),
                    'stock': int.tryParse(stockController.text.trim()) ?? 0,
                  };
                  Navigator.pop(context, newProduct);
                },
                child: Text('Save', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
    );

    if (result != null) {
      setState(() {
        if (isEditing) {
          products[index] = result;
        } else {
          products.add(result);
        }
      });
    }
  }

  void _deleteProduct(int index) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Delete Product'),
            content: Text(
              'Are you sure you want to delete "${products[index]['name']}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBC02D),
                ),
                onPressed: () {
                  setState(() {
                    products.removeAt(index);
                  });
                  Navigator.pop(context);
                },
                child: Text('Delete', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Products", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFBC02D),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Welcome back, Seller!\nHere’s your product list:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, index) {
                var p = products[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Text(
                      p['name'],
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      "Price: ${p['price']} • Stock: ${p['stock']}",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: Colors.black),
                      onSelected: (value) {
                        if (value == 'edit') _showProductForm(index: index);
                        if (value == 'delete') _deleteProduct(index);
                      },
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFFFBC02D),
        icon: Icon(Icons.add, color: Colors.black),
        label: Text("Add Product", style: TextStyle(color: Colors.black)),
        onPressed: () => _showProductForm(),
      ),
    );
  }
}
