import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseOrdersService {
  static final _client = Supabase.instance.client;

  // Place order
  static Future<Map<String, dynamic>> placeOrder({
    required List<Map<String, dynamic>> cartItems,
    required double totalAmount,
    required String deliveryAddress,
    required String phoneNumber,
    String? notes,
  }) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        return {
          'success': false,
          'message': 'Please login first',
        };
      }

      // Create order
      final orderResponse = await _client
          .from('orders')
          .insert({
            'user_id': user.id,
            'total_amount': totalAmount,
            'status': 'pending',
            'delivery_address': deliveryAddress,
            'phone_number': phoneNumber,
            'notes': notes,
          })
          .select()
          .single();

      final orderId = orderResponse['id'];

      // Create order items
      final orderItems = cartItems.map((cartItem) {
        final product = cartItem['products'];
        final quantity = cartItem['quantity'] as int;
        final price = product['price'] as num;
        
        return {
          'order_id': orderId,
          'product_id': product['id'],
          'product_name': product['name'],
          'price': price,
          'quantity': quantity,
          'subtotal': price * quantity,
        };
      }).toList();

      await _client.from('order_items').insert(orderItems);

      // Clear cart after successful order
      await _client
          .from('cart_items')
          .delete()
          .eq('user_id', user.id);

      return {
        'success': true,
        'message': 'Order placed successfully!',
        'order_id': orderId,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to place order: $e',
      };
    }
  }

  // Get user's orders
  static Future<List<Map<String, dynamic>>> getUserOrders() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return [];

      final response = await _client
          .from('orders')
          .select('''
            id,
            total_amount,
            status,
            delivery_address,
            phone_number,
            notes,
            created_at,
            order_items (
              id,
              product_name,
              price,
              quantity,
              subtotal
            )
          ''')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error getting orders: $e');
      return [];
    }
  }

  // Get order by ID
  static Future<Map<String, dynamic>?> getOrderById(String orderId) async {
    try {
      final response = await _client
          .from('orders')
          .select('''
            *,
            order_items (
              id,
              product_name,
              price,
              quantity,
              subtotal
            )
          ''')
          .eq('id', orderId)
          .maybeSingle();

      return response;
    } catch (e) {
      print('Error getting order: $e');
      return null;
    }
  }

  // Update order status (for admin/seller)
  static Future<bool> updateOrderStatus(String orderId, String status) async {
    try {
      await _client
          .from('orders')
          .update({
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId);

      return true;
    } catch (e) {
      print('Error updating order status: $e');
      return false;
    }
  }
}