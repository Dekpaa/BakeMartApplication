import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCartService {
  static final _client = Supabase.instance.client;

  // Add item to cart
  static Future<Map<String, dynamic>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        return {
          'success': false,
          'message': 'Please login first',
        };
      }

      // Check if item already exists in cart
      final existingItem = await _client
          .from('cart_items')
          .select()
          .eq('user_id', user.id)
          .eq('product_id', productId)
          .maybeSingle();

      if (existingItem != null) {
        // Update quantity if item exists
        await _client
            .from('cart_items')
            .update({
              'quantity': existingItem['quantity'] + quantity,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('user_id', user.id)
            .eq('product_id', productId);
      } else {
        // Insert new item
        await _client.from('cart_items').insert({
          'user_id': user.id,
          'product_id': productId,
          'quantity': quantity,
        });
      }

      return {
        'success': true,
        'message': 'Item added to cart!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to add item: $e',
      };
    }
  }

  // Get user's cart items
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return [];

      final response = await _client
          .from('cart_items')
          .select('''
            id,
            quantity,
            created_at,
            products (
              id,
              name,
              price,
              image_url,
              stock_quantity
            )
          ''')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error getting cart items: $e');
      return [];
    }
  }

  // Update cart item quantity
  static Future<bool> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      if (quantity <= 0) {
        return await removeCartItem(cartItemId);
      }

      await _client
          .from('cart_items')
          .update({
            'quantity': quantity,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', cartItemId);

      return true;
    } catch (e) {
      print('Error updating cart item: $e');
      return false;
    }
  }

  // Remove item from cart
  static Future<bool> removeCartItem(String cartItemId) async {
    try {
      await _client
          .from('cart_items')
          .delete()
          .eq('id', cartItemId);
      return true;
    } catch (e) {
      print('Error removing cart item: $e');
      return false;
    }
  }

  // Clear entire cart
  static Future<bool> clearCart() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return false;

      await _client
          .from('cart_items')
          .delete()
          .eq('user_id', user.id);
      return true;
    } catch (e) {
      print('Error clearing cart: $e');
      return false;
    }
  }

  // Get cart total
  static Future<double> getCartTotal() async {
    try {
      final cartItems = await getCartItems();
      double total = 0.0;
      
      for (final item in cartItems) {
        final quantity = item['quantity'] as int;
        final price = item['products']['price'] as num;
        total += quantity * price.toDouble();
      }
      
      return total;
    } catch (e) {
      print('Error calculating cart total: $e');
      return 0.0;
    }
  }
}