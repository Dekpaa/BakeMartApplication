import 'package:flutter/material.dart';
import '../supabase_orders_service.dart';
import 'home_page.dart';

class OrderTrackingPage extends StatefulWidget {
  final String orderId;

  const OrderTrackingPage({super.key, required this.orderId});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  Map<String, dynamic>? _orderData;
  bool _isLoading = true;

  final List<Map<String, dynamic>> _steps = [
    {"label": "Order Placed", "icon": Icons.check_circle, "status": "pending"},
    {"label": "Processing", "icon": Icons.settings, "status": "confirmed"},
    {"label": "Shipped", "icon": Icons.local_shipping, "status": "shipped"},
    {"label": "Out for Delivery", "icon": Icons.delivery_dining, "status": "out_for_delivery"},
    {"label": "Delivered", "icon": Icons.home, "status": "delivered"},
  ];

  @override
  void initState() {
    super.initState();
    _loadOrderData();
  }

  Future<void> _loadOrderData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final orderData = await SupabaseOrdersService.getOrderById(widget.orderId);
      setState(() {
        _orderData = orderData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading order: $e')),
      );
    }
  }

  int _getCurrentStepIndex(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 0;
      case 'confirmed':
        return 1;
      case 'shipped':
        return 2;
      case 'out_for_delivery':
        return 3;
      case 'delivered':
        return 4;
      case 'cancelled':
        return -1;
      default:
        return 0;
    }
  }

  String _getStatusMessage(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Your order has been received and is being processed.';
      case 'confirmed':
        return 'Your order has been confirmed and is being prepared.';
      case 'shipped':
        return 'Your order is on the way to you.';
      case 'out_for_delivery':
        return 'Your order is out for delivery and will arrive soon.';
      case 'delivered':
        return 'Your order has been successfully delivered!';
      case 'cancelled':
        return 'Your order has been cancelled.';
      default:
        return 'Unknown status';
    }
  }

  // ADD THIS NEW FUNCTION
  String _getNextStatus(String currentStatus) {
    switch (currentStatus.toLowerCase()) {
      case 'pending': return 'confirmed';
      case 'confirmed': return 'shipped';
      case 'shipped': return 'out_for_delivery';
      case 'out_for_delivery': return 'delivered';
      default: return currentStatus;
    }
  }

  // ADD THIS NEW FUNCTION
  Future<void> _updateOrderStatus() async {
    if (_orderData == null) return;
    
    final currentStatus = _orderData!['status'];
    final nextStatus = _getNextStatus(currentStatus);
    
    if (nextStatus == currentStatus) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order is already at final status')),
      );
      return;
    }

    try {
      final success = await SupabaseOrdersService.updateOrderStatus(
        widget.orderId, 
        nextStatus
      );
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order status updated to ${nextStatus.toUpperCase()}!'),
            backgroundColor: Colors.green,
          ),
        );
        _loadOrderData(); // Refresh order data
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update order status'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Tracking",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFBC02D),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadOrderData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _orderData == null
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Order not found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Info Card
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order ID: ${widget.orderId}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Total: RM${_orderData!['total_amount'].toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Status: ${_orderData!['status'].toString().toUpperCase()}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _orderData!['status'] == 'delivered' 
                                      ? Colors.green 
                                      : _orderData!['status'] == 'cancelled'
                                          ? Colors.red
                                          : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _getStatusMessage(_orderData!['status']),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Delivery Address
                      if (_orderData!['delivery_address'] != null)
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.location_on, color: Colors.red),
                            title: const Text(
                              'Delivery Address',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(_orderData!['delivery_address']),
                          ),
                        ),

                      const SizedBox(height: 20),

                      // Tracking Steps
                      const Text(
                        "Tracking Status",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: _orderData!['status'] == 'cancelled'
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      size: 80,
                                      color: Colors.red.shade300,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Order Cancelled',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'This order has been cancelled.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: _steps.length,
                                itemBuilder: (context, index) {
                                  final currentStepIndex = _getCurrentStepIndex(_orderData!['status']);
                                  final isCompleted = index < currentStepIndex;
                                  final isCurrent = index == currentStepIndex;
                                  final isUpcoming = index > currentStepIndex;

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: Card(
                                      elevation: isCurrent ? 4 : 1,
                                      color: isCurrent 
                                          ? Colors.orange.shade50 
                                          : isCompleted 
                                              ? Colors.green.shade50 
                                              : Colors.grey.shade50,
                                      child: ListTile(
                                        leading: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: isCompleted 
                                                ? Colors.green 
                                                : isCurrent 
                                                    ? Colors.orange 
                                                    : Colors.grey.shade300,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            isCompleted 
                                                ? Icons.check 
                                                : _steps[index]["icon"],
                                            color: isCompleted || isCurrent 
                                                ? Colors.white 
                                                : Colors.grey.shade600,
                                            size: 20,
                                          ),
                                        ),
                                        title: Text(
                                          _steps[index]["label"],
                                          style: TextStyle(
                                            color: isUpcoming ? Colors.grey : Colors.black,
                                            fontWeight: isCurrent || isCompleted 
                                                ? FontWeight.bold 
                                                : FontWeight.normal,
                                          ),
                                        ),
                                        trailing: isCompleted
                                            ? const Icon(Icons.check_circle, color: Colors.green)
                                            : isCurrent
                                                ? Icon(Icons.radio_button_checked, color: Colors.orange)
                                                : Icon(Icons.radio_button_unchecked, color: Colors.grey.shade400),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),

                      // Bottom Actions - UPDATED WITH 3 BUTTONS
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.home),
                              label: const Text('Home'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _loadOrderData,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Refresh'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFBC02D),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _orderData!['status'] == 'delivered' 
                                  ? null 
                                  : _updateOrderStatus,
                              icon: const Icon(Icons.update),
                              label: const Text('Next'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}