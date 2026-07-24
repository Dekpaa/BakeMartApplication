import 'package:flutter/material.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  List<Map<String, dynamic>> orders = [
    {
      'id': '#001',
      'customer': 'Ali',
      'items': 'Flour, Cocoa',
      'status': 'Pending',
    },
    {'id': '#002', 'customer': 'Siti', 'items': 'Yeast', 'status': 'Preparing'},
  ];

  Color getCardColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange.shade100;
      case 'Preparing':
        return Colors.blue.shade100;
      case 'Delivered':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFBC02D),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Here are your recent orders:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (_, index) {
                var o = orders[index];
                return Card(
                  color: getCardColor(o['status']),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Text(
                      "Order ${o['id']} • ${o['customer']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Items: ${o['items']}",
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: DropdownButton<String>(
                      value: o['status'],
                      icon: Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.white,
                      style: TextStyle(color: Colors.black),
                      items:
                          ['Pending', 'Preparing', 'Delivered'].map((status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                      onChanged: (val) {
                        setState(() {
                          orders[index]['status'] = val!;
                        });
                      },
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
