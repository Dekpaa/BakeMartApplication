import 'package:flutter/material.dart';
import 'my_products_tab.dart';
import 'orders_tab.dart';
import 'profile_tab.dart';
import 'tutorial_page.dart';

class SellerMainDashboard extends StatefulWidget {
  const SellerMainDashboard({super.key});

  @override
  State<SellerMainDashboard> createState() => _SellerMainDashboardState();
}

class _SellerMainDashboardState extends State<SellerMainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MyProductsTab(),
    OrdersTab(),
    TutorialPage(isFromDashboard: true), // Reuse tutorial tab
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFFBC02D),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'My Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Tutorials',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
