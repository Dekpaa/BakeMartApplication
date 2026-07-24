import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    // Replace with your Supabase project credentials
    url: 'https://ivrlephfdfgtykrjnakc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml2cmxlcGhmZGZndHlrcmpuYWtjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE3MTk5NzgsImV4cCI6MjA2NzI5NTk3OH0.QZueAmr2KEuJJV_DzmhOEZiY67A71Z3qwzHuYlBoqKg',
  );

  runApp(const BakeMartApp());
}

class BakeMartApp extends StatelessWidget {
  const BakeMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bake Mart',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const WelcomePage(),
    );
  }
}

// Get Supabase instance
final supabase = Supabase.instance.client;