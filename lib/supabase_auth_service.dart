import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  static final _client = Supabase.instance.client;

  // Register new user
  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      // Combine name with additional data (like phone)
      final userData = {
        'name': name,
        ...?additionalData, // Spread operator to include phone, etc.
      };

      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: userData, // Include all user data
      );

      if (response.user != null) {
        return {
          'success': true,
          'user': response.user,
          'message': 'Registration successful! Please check your email for verification.',
        };
      } else {
        return {
          'success': false,
          'message': 'Registration failed. Please try again.',
        };
      }
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Something went wrong: $e',
      };
    }
  }

  // Login user
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return {
          'success': true,
          'user': response.user,
          'message': 'Login successful!',
        };
      } else {
        return {
          'success': false,
          'message': 'Login failed. Please try again.',
        };
      }
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Something went wrong: $e',
      };
    }
  }

  // Logout
  static Future<void> logout() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      print('Logout error: $e');
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _client.auth.currentUser != null;
  }

  // Reset password
  static Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
      return {
        'success': true,
        'message': 'Password reset email sent!',
      };
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Something went wrong: $e',
      };
    }
  }
}