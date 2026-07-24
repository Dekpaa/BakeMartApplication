import 'package:flutter/material.dart';
import 'chocolate_recipe_page.dart';
import 'banana_recipe_page.dart';
import 'cart_page.dart';
import 'home_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // Recipes with detailed pages
  final List<Map<String, dynamic>> detailedRecipes = [
    {'name': 'Chocolate Cake', 'rating': 5, 'image': Icons.cake, 'type': 'detailed'},
    {'name': 'Banana Bread', 'rating': 4, 'image': Icons.bakery_dining, 'type': 'detailed'},
  ];

  // Simple recipes without detail pages
  final List<Map<String, dynamic>> simpleRecipes = [
    {'name': 'Vanilla Muffin', 'rating': 4, 'image': Icons.emoji_food_beverage, 'type': 'simple'},
    {'name': 'Strawberry Tart', 'rating': 5, 'image': Icons.local_cafe, 'type': 'simple'},
    {'name': 'Lemon Cake', 'rating': 4, 'image': Icons.cake_outlined, 'type': 'simple'},
    {'name': 'Blueberry Scones', 'rating': 5, 'image': Icons.breakfast_dining, 'type': 'simple'},
  ];

  List<Map<String, dynamic>> get allRecipes => [...detailedRecipes, ...simpleRecipes];

  List<Map<String, dynamic>> filteredRecipes = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredRecipes = allRecipes;
  }

  void _filterRecipes(String query) {
    final result = allRecipes.where((recipe) {
      final name = recipe['name'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredRecipes = result;
    });
  }

  Widget buildRecipeItem(Map<String, dynamic> recipe) {
    final bool hasDetailPage = recipe['type'] == 'detailed';
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.orange[100],
          child: Icon(recipe['image'], color: Colors.deepOrange, size: 28),
        ),
        title: Text(
          recipe['name'],
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < recipe['rating'] ? Colors.amber : Colors.grey[300],
                  size: 16,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              hasDetailPage ? 'View Recipe & Ingredients' : 'Recipe coming soon!',
              style: TextStyle(
                color: hasDetailPage ? Colors.blue : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: hasDetailPage 
            ? const Icon(Icons.arrow_forward_ios, color: Colors.orange)
            : const Icon(Icons.lock_outline, color: Colors.grey),
        onTap: () {
          if (hasDetailPage) {
            if (recipe['name'] == 'Chocolate Cake') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChocolateRecipePage()),
              );
            } else if (recipe['name'] == 'Banana Bread') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BananaRecipePage()),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Recipe for ${recipe['name']} is coming soon!')),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove bottomNavigationBar completely since got duplicate
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBC02D),
        title: const Text(
          "BAKEMART",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section - Recipes only
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade200, Colors.orange.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.menu_book, size: 80, color: Colors.white),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "RECIPE COLLECTION",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Delicious baking recipes",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Scroll to recipes or do nothing since we're already showing recipes
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        elevation: 2,
                      ),
                      child: const Text("Browse Recipes"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          
          // Section header
          Container(
            color: Colors.orange[50],
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Text(
              "BAKING RECIPES",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          
          // Recipe list
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                return buildRecipeItem(filteredRecipes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}