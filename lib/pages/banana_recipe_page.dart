import 'package:flutter/material.dart';
import '../supabase_cart_service.dart';
import 'product_details.dart';
import 'cart_page.dart';

class BananaRecipePage extends StatefulWidget {
  const BananaRecipePage({super.key});

  @override
  State<BananaRecipePage> createState() => _BananaRecipePageState();
}

class _BananaRecipePageState extends State<BananaRecipePage> {
  bool isAddingToCart = false;
  
  // Ingredients yang available untuk purchase
  final List<Map<String, dynamic>> availableIngredients = [
    {
      'id': '550e8400-e29b-41d4-a716-446655440001',
      'name': 'Premium Flour',
      'price': 5.99,
      'needed': '1.5 cups all-purpose flour',
      'icon': Icons.grain,
    },
    {
      'id': '550e8400-e29b-41d4-a716-446655440003',
      'name': 'Vanilla Extract',
      'price': 12.00,
      'needed': '1 tsp vanilla essence',
      'icon': Icons.local_florist,
    },
  ];

  final List<String> otherIngredients = [
    '3 ripe bananas, mashed',
    '1/2 cup brown sugar',
    '1/3 cup melted butter',
    '1 tsp baking soda',
    '1 egg',
    'Pinch of salt',
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
      backgroundColor: const Color.fromARGB(255, 255, 253, 245),
      appBar: AppBar(
        title: const Text('Banana Bread Recipe'),
        backgroundColor: const Color.fromARGB(255, 224, 153, 47),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
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
              Icon(Icons.bakery_dining, color: Colors.brown, size: 30),
              SizedBox(width: 10),
              Text(
                'Price: RM 20.00',
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
            '🍌 Other Ingredients (Buy Separately)',
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
                Text('1. Preheat oven to 175°C (350°F).'),
                Text('2. Mash bananas in a bowl.'),
                Text('3. Mix in melted butter, egg, and vanilla.'),
                Text('4. Add baking soda and salt.'),
                Text('5. Stir in flour until just combined.'),
                Text('6. Pour batter into greased loaf pan.'),
                Text('7. Bake for 45–55 minutes.'),
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
                Text('• Use overripe bananas for best flavor.'),
                Text('• Do not overmix the batter.'),
                Text('• Add chopped walnuts or chocolate chips for extra texture.'),
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
                    backgroundColor: const Color.fromRGBO(245, 124, 0, 1),
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