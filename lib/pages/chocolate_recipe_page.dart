import 'package:flutter/material.dart';
import '../supabase_cart_service.dart';
import 'product_details.dart';
import 'cart_page.dart';

class ChocolateRecipePage extends StatefulWidget {
  const ChocolateRecipePage({super.key});

  @override
  State<ChocolateRecipePage> createState() => _ChocolateRecipePageState();
}

class _ChocolateRecipePageState extends State<ChocolateRecipePage> {
  bool isAddingToCart = false;
  
  // Ingredients yang available untuk purchase
  final List<Map<String, dynamic>> availableIngredients = [
    {
      'id': '550e8400-e29b-41d4-a716-446655440001',
      'name': 'Premium Flour',
      'price': 5.99,
      'needed': '2 cups all-purpose flour',
      'icon': Icons.grain,
    },
    {
      'id': '550e8400-e29b-41d4-a716-446655440002', 
      'name': 'Cocoa Powder',
      'price': 8.50,
      'needed': '1 cup cocoa powder',
      'icon': Icons.coffee,
    },
    {
      'id': '550e8400-e29b-41d4-a716-446655440003',
      'name': 'Vanilla Extract',
      'price': 12.00,
      'needed': '1 tsp vanilla extract',
      'icon': Icons.local_florist,
    },
  ];

  final List<String> otherIngredients = [
    '1.5 cups granulated sugar',
    '2 large eggs',
    '1 cup fresh milk',
    '1 tsp baking soda',
    '1/2 cup butter (softened)',
  ];

  Future<void> _addIngredientToCart(String productId, String productName) async {
    setState(() {
      isAddingToCart = true;
    });

    try {
      final result = await SupabaseCartService.addToCart(
        productId: productId,
        quantity: 1,
      );

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$productName added to cart!'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'View Cart',
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartPage()),
                );
              },
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isAddingToCart = false;
      });
    }
  }

  Future<void> _addAllIngredientsToCart() async {
    setState(() {
      isAddingToCart = true;
    });

    try {
      for (final ingredient in availableIngredients) {
        await SupabaseCartService.addToCart(
          productId: ingredient['id'],
          quantity: 1,
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('All available ingredients added to cart!'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'View Cart',
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isAddingToCart = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      appBar: AppBar(
        title: const Text('Chocolate Cake Recipe'),
        backgroundColor: const Color.fromARGB(255, 224, 153, 47),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Recipe Info
          Row(
            children: const [
              Icon(Icons.cake_outlined, color: Colors.brown, size: 30),
              SizedBox(width: 10),
              Text(
                'Price: RM 35.00',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Available Ingredients Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Available Ingredients',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: isAddingToCart ? null : _addAllIngredientsToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                icon: isAddingToCart 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.add_shopping_cart, size: 16),
                label: Text(
                  isAddingToCart ? 'Adding...' : 'Add All',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Available Ingredients List
          ...availableIngredients.map((ingredient) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(
                  ingredient['icon'],
                  color: Colors.orange,
                  size: 24,
                ),
                title: Text(
                  ingredient['needed'],
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  '${ingredient['name']} - RM${ingredient['price'].toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // View Details Button
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(
                              product: {
                                'id': ingredient['id'],
                                'name': ingredient['name'],
                                'price': ingredient['price'],
                                'image': ingredient['icon'],
                                'description': 'Premium baking ingredient for ${ingredient['name']}',
                                'stock': 50,
                                'rating': 5,
                                'category': 'Baking',
                              }
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        side: const BorderSide(color: Colors.orange),
                      ),
                      child: const Text(
                        'Details',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Add to Cart Button
                    ElevatedButton(
                      onPressed: isAddingToCart 
                          ? null 
                          : () {
                              _addIngredientToCart(
                                ingredient['id'], 
                                ingredient['name']
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      child: isAddingToCart 
                          ? const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Add to Cart',
                              style: TextStyle(fontSize: 10),
                            ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

          const SizedBox(height: 20),

          // Other Ingredients Section
          const Text(
            'Other Ingredients (Buy Separately)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: otherIngredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 6, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(ingredient),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Tutorial Steps
          const Text(
            '📖 Tutorial Steps',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. Preheat oven to 180°C.'),
                Text('2. Mix all dry ingredients in a large bowl.'),
                Text('3. In another bowl, beat eggs, milk, vanilla, and butter.'),
                Text('4. Slowly combine wet and dry ingredients.'),
                Text('5. Pour mixture into a greased cake pan.'),
                Text('6. Bake for 30–35 minutes until a toothpick comes out clean.'),
                Text('7. Cool on a rack before frosting or serving.'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Baking Tips
          const Text(
            '💡 Baking Tips',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Always use room-temperature eggs and milk.'),
                Text('• Sift dry ingredients for a smoother batter.'),
                Text('• Do not overmix to avoid a dense cake.'),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Bottom Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Colors.orange),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(245, 241, 111, 10),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('View Cart'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}